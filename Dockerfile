# Stage 1: Build the jar using Maven with Java 21
FROM maven:3.9.8-eclipse-temurin-21 AS build

WORKDIR /app

# Copy only the pom.xml first to cache dependencies and speed up builds
COPY pom.xml .

# Copy source code
COPY src ./src

# Build the jar file, skipping tests for faster builds (optional)
RUN mvn clean package -DskipTests

# Stage 2: Run the jar with a lightweight Java runtime
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/chat-app-backend-0.0.1-SNAPSHOT.jar app.jar

# Expose your app's port (update to 5459 if you configured it)
EXPOSE 5459

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
