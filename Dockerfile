# Usamos Java 17
FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY . .

RUN chmod +x gradlew

RUN ./gradlew clean build -x test

# CAMBIO CRÍTICO AQUÍ:
# 1. -Xmx350m: Limita la memoria para que Render no mate la app.
# 2. -Dserver.port=10000: Obliga a Grails a usar el puerto correcto.
CMD find build/libs -name "*.jar" -type f -exec java -Xmx350m -Dserver.port=10000 -jar {} \;