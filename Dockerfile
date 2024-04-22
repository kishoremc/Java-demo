FROM maven:3.8.4-openjdk-11 AS build

WORKDIR /usr/src/my-java-app

COPY . .

RUN mvn clean package

FROM openjdk:alpine

WORKDIR /usr/src/my-java-app

COPY --from=build /usr/src/my-java-app/target/*.jar ./my-java-app.jar

CMD ["java", "-jar", "my-java-app.jar"]
