# syntax=docker/dockerfile:1

FROM eclipse-temurin:17
WORKDIR /code

COPY . ./
RUN ./mvnw package

WORKDIR ./target

CMD ["java", "-jar", "*.jar"]