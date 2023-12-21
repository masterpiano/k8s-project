FROM eclipse-temurin:17 as builder
WORKDIR /app
COPY . ./
RUN ./mvnw package


FROM eclipse-temurin:17-jre as runner
EXPOSE 80
WORKDIR /code
COPY --from=builder /app/target/*.jar ./
CMD java -jar ./*.jar