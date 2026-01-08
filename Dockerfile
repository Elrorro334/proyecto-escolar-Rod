FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY . .

RUN chmod +x gradlew

RUN ./gradlew clean build -x test

CMD find build/libs -name "*.war" -type f -exec java -Xmx256m -Dserver.port=10000 -jar {} \;