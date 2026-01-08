# Usamos la imagen oficial actual (Eclipse Temurin) con Java 11
FROM eclipse-temurin:11-jdk

# Directorio de trabajo
WORKDIR /app

# Copiamos todos los archivos
COPY . .

# Damos permisos de ejecución al instalador de Gradle
RUN chmod +x gradlew

# Construimos la app (el comando 'clean build' evita caché corrupto)
# '-x test' salta las pruebas para que despliegue más rápido
RUN ./gradlew clean build -x test

# Buscamos y ejecutamos el .jar automáticamente
CMD find build/libs -name "*.jar" -type f -exec java -jar {} \;