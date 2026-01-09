FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY . .

RUN chmod +x gradlew
RUN ./gradlew clean build -x test

CMD java -Xms128m -Xmx256m -XX:+UseSerialGC -Xss512k \
    -Dserver.port=$PORT \
    -Dserver.address=0.0.0.0 \
    -jar build/libs/app.war
