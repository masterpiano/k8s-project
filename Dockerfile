FROM eclipse-temurin:17
WORKDIR /code

COPY . ./
RUN ./mvnw package

EXPOSE 80
WORKDIR ./target

CMD java -jar ./*.jar