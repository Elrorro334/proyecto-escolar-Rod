# Usamos Java 11 (estándar para Grails)
FROM openjdk:11-jdk-slim

# Directorio de trabajo
WORKDIR /app

# Copiamos tus archivos
COPY . .

# Damos permisos al instalador
RUN chmod +x gradlew

# Creamos la aplicación (sin correr tests para que sea rápido)
RUN ./gradlew clean build -x test

# AQUI ESTÁ LA LÍNEA MÁGICA:
# Busca el .jar automáticamente y lo arranca.
CMD find build/libs -name "*.jar" -type f -exec java -jar {} \;