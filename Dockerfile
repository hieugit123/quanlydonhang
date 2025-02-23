FROM maven:3-openjdk-17 AS build
WORKDIR /app

COPY . .
RUN mvn clean package -DskipTests && rm -rf /root/.m2/repository


# Run stage

FROM openjdk:17-jdk-slim
WORKDIR /app

COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.war demo.war

RUN mkdir -p /app/uploads
VOLUME ["/app/uploads"]

EXPOSE 8080

ENTRYPOINT ["java","-jar","demo.war"]
