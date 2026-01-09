FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY . .

RUN chmod +x gradlew

RUN ./gradlew clean bootWar -x test

EXPOSE 10000

CMD java -Xms128m -Xmx200m -XX:+UseSerialGC -Xss512k \
    -Dgrails.env=prod \
    -Dserver.port=10000 \
    -Dserver.address=0.0.0.0 \
    -jar build/libs/*.war