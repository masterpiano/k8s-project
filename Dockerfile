FROM eclipse-temurin:17-alpine as builder
WORKDIR /app
COPY ./spring-petclinic ./
# RUN chmod +x mvnw
RUN ./mvnw package

FROM eclipse-temurin:17-jre-alpine as runner
EXPOSE 80
WORKDIR /code
COPY --from=builder /app/target/*.jar ./
CMD java -jar ./*.jar
