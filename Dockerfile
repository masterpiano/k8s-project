# syntax=docker/dockerfile:1

FROM eclipse-temurin:8 AS base
WORKDIR /code

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:resolve

COPY src ./src

CMD ["./mvnw", "spring-boot:run"]