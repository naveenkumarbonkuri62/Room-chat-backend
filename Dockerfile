# Use Java 21 (as per your POM)
FROM eclipse-temurin:21-jdk-alpine

# Set working directory
WORKDIR /app

# Copy your jar file
COPY target/chat-app-backend-0.0.1-SNAPSHOT.jar app.jar

# Expose port 5459 for your app
EXPOSE 5459

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
