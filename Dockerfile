FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY . .

RUN chmod +x gradlew

RUN ./gradlew clean bootWar -x test --no-daemon

CMD java $JAVA_OPTS \
    -Dgrails.env=prod \
    -Dserver.port=$PORT \
    -Dserver.address=0.0.0.0 \
    -jar build/libs/*.war