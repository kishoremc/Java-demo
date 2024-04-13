# Use the official Maven image as base for the build stage
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory in the container
WORKDIR /usr/src/my-java-app

# Copy the project's source code and pom.xml file into the container
COPY . .

# Build the application inside the container
RUN mvn clean package

# Debugging command to list contents of the target directory
RUN ls -l /usr/src/my-java-app/target/

# Use the official OpenJDK image as base for the runtime stage
FROM openjdk:alpine

# Set the working directory in the container
WORKDIR /usr/src/my-java-app

# Copy the compiled JAR file from the build stage into the runtime stage
COPY --from=build /usr/src/my-java-app/target/*.jar ./my-java-app.jar

# Command to run the application
CMD ["java", "-jar", "my-java-app.jar"]
