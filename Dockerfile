FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY . .

RUN chmod +x gradlew

RUN ./gradlew clean build -x test

CMD find build/libs -name "*.war" ! -name "*plain*" -type f -exec java -Xmx256m -Dserver.port=10000 -Dserver.address=0.0.0.0 -jar {} \;