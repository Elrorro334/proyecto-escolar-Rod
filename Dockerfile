FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY . .

RUN chmod +x gradlew

RUN ./gradlew clean bootWar -x test

CMD java -Xms128m -Xmx200m -XX:+UseSerialGC -Xss512k \
    -Dgrails.env=prod \
    -Dserver.port=$PORT \
    -Dserver.address=0.0.0.0 \
    -jar build/libs/app.war