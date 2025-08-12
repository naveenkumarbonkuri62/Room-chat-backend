# Stage 1: Build with Maven
FROM maven:3.9.3-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the jar with lightweight JRE
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/chat-app-backend-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 5459
ENTRYPOINT ["java", "-jar", "app.jar"]
