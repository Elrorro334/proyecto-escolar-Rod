# ETAPA 1: Construcción
FROM eclipse-temurin:17-jdk-jammy AS builder
WORKDIR /app

# Copiar archivos de Gradle
COPY gradle/ gradle/
COPY gradlew build.gradle gradle.properties settings.gradle ./ 

RUN chmod +x gradlew

# Cachear dependencias
RUN ./gradlew dependencies --no-daemon || true

# Copiar código fuente
COPY grails-app/ grails-app/
COPY src/ src/

# Compilar WAR
RUN ./gradlew clean bootWar -x test --no-daemon

# ETAPA 2: Ejecución
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Crear usuario no-root (Seguridad)
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Copiar WAR
COPY --from=builder /app/build/libs/*.war app.war

# Ajustar permisos
RUN chown appuser:appuser app.war

USER appuser

# Render inyectará el PORT automáticamente, pero definimos default
ENV PORT=8080

EXPOSE ${PORT}

# FIX CRÍTICO: Usamos sh -c para que lea la variable ${PORT}
CMD ["sh", "-c", "java -XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -Djava.security.egd=file:/dev/./urandom -Dgrails.env=prod -Dserver.port=${PORT} -jar app.war"]