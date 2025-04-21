# Final Project Group 6 - Tree Planting Management System

## Project Overview

This project is a Java application designed to manage tree planting activities in Oakland neighborhoods. It allows users (residents, volunteers, admins) to request trees, manage permits, schedule site visits, track plantings, and generate reports. The system uses a MySQL database to store data.

## Significant Files and Directories

*   **`/ddl.sql`**: Contains the SQL Data Definition Language (DDL) statements to create the database schema (tables, constraints, etc.).
*   **`/dml.sql`**: Contains the SQL Data Manipulation Language (DML) statements to populate the database with initial lookup data and sample test data.
*   **`/java-app/`**: The root directory for the Java application source code and Maven project configuration.
    *   **`pom.xml`**: Maven Project Object Model file. Defines project dependencies (like the MySQL JDBC driver), build configurations, and plugins needed to compile and package the Java application.
    *   **`src/main/java/`**: Contains the Java source code.
        *   **`DAO/`**: Data Access Object classes ([`AdminDAO.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/DAO/AdminDAO.java), [`TreeRequestDAO.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/DAO/TreeRequestDAO.java), [`UserDAO.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/DAO/UserDAO.java), [`PermitDAO.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/DAO/PermitDAO.java), [`VolunteerDAO.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/DAO/VolunteerDAO.java), etc.). These classes handle all interactions with the MySQL database.
        *   **`Model/`**: Plain Old Java Objects (POJOs) representing the data entities ([`User.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/Model/User.java), [`TreeRequest.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/Model/TreeRequest.java), [`TreeSpecies.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/Model/TreeSpecies.java), [`Volunteer.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/Model/Volunteer.java), etc.).
        *   **`tasks/`**: Java classes ([`TaskA.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskA.java), [`TaskB.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskB.java), [`TaskC.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskC.java), [`TaskDE.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskDE.java), [`TaskF.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskF.java), [`TaskG.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskG.java), [`TaskH.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskH.java), [`TaskI.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskI.java), [`TaskJ.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskJ.java), [`TaskK.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskK.java), [`TaskL_stored_procedure.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskL_stored_procedure.java)). Each class typically contains a `main` method to execute a specific application feature or workflow, often interacting with DAOs.
        *   **`util/DBConnection.java`**: Utility class for managing the database connection. Reads connection details from environment variables or potentially hardcoded values (should be configured via environment variables for Docker).
*   **`/Dockerfile`**: (To be created) Defines the steps to build a Docker image for the Java application. This typically involves:
    1.  Using a base image with Java and Maven (e.g., `maven:3.8-openjdk-17`).
    2.  Copying the `pom.xml` and source code (`java-app/`).
    3.  Running Maven (`mvn package`) to compile the code and build an executable JAR file.
    4.  Using a smaller Java runtime base image (e.g., `openjdk:17-jdk-slim`).
    5.  Copying the built JAR file from the build stage.
    6.  Setting the `ENTRYPOINT` to run the Java application (e.g., `java -cp app.jar tasks.TaskClassName`).
*   **`/docker-compose.yml`**: (To be created) Defines and configures the multi-container Docker application (database and Java application). It specifies:
    1.  The MySQL service, using the official `mysql:8.0` image, setting environment variables for `MYSQL_ROOT_PASSWORD`, `MYSQL_DATABASE`, `MYSQL_USER`, `MYSQL_PASSWORD`, mapping port `3306`, and mounting `ddl.sql` and `dml.sql` into `/docker-entrypoint-initdb.d/` to initialize the database on startup. A volume should be used for data persistence.
    2.  The Java application service, building from the `Dockerfile`, mapping ports (if necessary), setting environment variables for database connection (`DB_URL`, `DB_USER`, `DB_PASSWORD`), and specifying dependencies (`depends_on: db`).

## How to Compile, Configure, and Run (Docker)

**Prerequisites:**

*   Docker: [Install Docker](https://docs.docker.com/get-docker/)
*   Docker Compose: Usually included with Docker Desktop. [Install Docker Compose](https://docs.docker.com/compose/install/)
*   Maven: Required for the build process within Docker, but not necessarily on the host machine if using the multi-stage Dockerfile.

**Steps:**

1.  **Create `Dockerfile`:**
    ````dockerfile
    # filepath: Dockerfile
    # Stage 1: Build the application using Maven
    FROM maven:3.8.4-openjdk-17 AS build
    WORKDIR /app
    # Copy pom.xml first to leverage Docker cache for dependencies
    COPY java-app/pom.xml .
    RUN mvn dependency:go-offline
    # Copy the rest of the source code
    COPY java-app/src ./src
    # Compile and package the application into a JAR
    RUN mvn package -DskipTests

    # Stage 2: Create the runtime image
    FROM openjdk:17-jdk-slim
    WORKDIR /app
    # Copy the JAR file from the build stage
    COPY --from=build /app/target/*.jar app.jar
    # Expose port if it were a web application
    # EXPOSE 8080
    # Set the entry point. Since the app consists of multiple 'Task' classes
    # with main methods, the user needs to specify which task to run.
    ENTRYPOINT ["java", "-cp", "app.jar"]
    # Example usage: docker-compose run app tasks.TaskA
    # Example usage: docker-compose run app tasks.TaskB
    ````

2.  **Create `docker-compose.yml`:**
    ````yaml
    # filepath: docker-compose.yml
    version: '3.8'
    services:
      db:
        image: mysql:8.0
        container_name: mysql-db
        ports:
          # Map host machine port 3306 to container port 3306
          - "3306:3306"
        environment:
          # Define MySQL credentials and database name
          MYSQL_ROOT_PASSWORD: rootpassword # Use a strong password in production
          MYSQL_DATABASE: tree_planting_db # Database name used in DBConnection
          MYSQL_USER: dbuser               # Application user
          MYSQL_PASSWORD: dbpassword       # Application user password (use a strong one)
        volumes:
          # Mount SQL scripts to initialize the database on first run
          - ./ddl.sql:/docker-entrypoint-initdb.d/1_schema.sql
          - ./dml.sql:/docker-entrypoint-initdb.d/2_data.sql
          # Named volume to persist database data across container restarts
          - mysql_data:/var/lib/mysql
        healthcheck:
          # Check if the database is ready to accept connections
          test: ["CMD", "mysqladmin" ,"ping", "-h", "localhost", "-u$$MYSQL_USER", "-p$$MYSQL_PASSWORD"]
          interval: 10s
          timeout: 5s
          retries: 5

      app:
        build:
          context: . # Build the image from the Dockerfile in the current directory
          dockerfile: Dockerfile
        container_name: java-app
        depends_on:
          db:
            condition: service_healthy # Wait for the db service to be healthy before starting app
        environment:
          # Pass database connection details to the Java application
          DB_URL: jdbc:mysql://db:3306/tree_planting_db # 'db' is the service name of the database container
          DB_USER: dbuser
          DB_PASSWORD: dbpassword # Use the same password as defined for the db service
        stdin_open: true # Keep stdin open to allow interaction with the console application
        tty: true        # Allocate a pseudo-TTY for interaction

    volumes:
      # Define the named volume for MySQL data persistence
      mysql_data:
    ````

3.  **Update `DBConnection.java`:** Ensure it reads connection details from the environment variables set in `docker-compose.yml`.
    ````java
    // filepath: /Users/mac/MySQL/project-project-6/java-app/src/main/java/util/DBConnection.java
    package util;

    import java.sql.Connection;
    import java.sql.DriverManager;
    import java.sql.SQLException;

    public class DBConnection {
        // Read connection details from environment variables provided by Docker Compose
        private static final String DB_URL = System.getenv("DB_URL"); // e.g., jdbc:mysql://db:3306/tree_planting_db
        private static final String DB_USER = System.getenv("DB_USER"); // e.g., dbuser
        private static final String DB_PASSWORD = System.getenv("DB_PASSWORD"); // e.g., dbpassword

        static {
            try {
                // Ensure the MySQL JDBC driver is loaded
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                System.err.println("FATAL: MySQL JDBC Driver not found. Ensure it's in the classpath (pom.xml).");
                // Throwing a runtime exception might be appropriate here to halt execution
                throw new RuntimeException("MySQL JDBC Driver not found", e);
            }
             // Basic check if environment variables are set during startup
            if (DB_URL == null || DB_USER == null || DB_PASSWORD == null) {
                System.err.println("FATAL: Database environment variables (DB_URL, DB_USER, DB_PASSWORD) are not set.");
                System.err.println("Ensure they are provided when running the container (e.g., via docker-compose.yml).");
                // Throwing an exception prevents the application from continuing without configuration.
                 throw new IllegalStateException("Database configuration environment variables not set.");
            } else {
                 System.out.println("DB Connection details loaded from environment variables."); // Info message
            }
        }

        /**
         * Establishes and returns a database connection using credentials from environment variables.
         * @return A Connection object to the database.
         * @throws SQLException if a database access error occurs or the URL is null,
         *                      or if the environment variables were not properly set.
         */
        public static Connection getConnection() throws SQLException {
             if (DB_URL == null || DB_USER == null || DB_PASSWORD == null) {
                // This check is redundant if the static block throws an exception, but good for safety.
                throw new SQLException("Database configuration environment variables are missing.");
            }
            // Establish and return the database connection
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        }

        // Optional: Method to close connection (though try-with-resources is preferred in DAO methods)
        public static void closeConnection(Connection connection) {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    System.err.println("Error closing database connection:");
                    e.printStackTrace();
                }
            }
        }
    }
    ````

4.  **Build and Run:**
    *   Open a terminal in the project's root directory (where `docker-compose.yml` and `Dockerfile` are located).
    *   Run `docker-compose build` to build the `app` image (and pull `mysql` if needed).
    *   Run `docker-compose up db -d` to start the database container in the background and wait for it to become healthy.
    *   Once the database is running, you can run specific tasks using `docker-compose run app <fully.qualified.TaskClassName>`. For example:
        *   `docker-compose run app tasks.TaskA` (for user registration)
        *   `docker-compose run app tasks.TaskB` (for submitting a tree request)
        *   `docker-compose run app tasks.TaskK` (for running reports)
        *   ... and so on for other tasks.
    *   The output of the specific task will appear in your terminal.

5.  **Stopping:**
    *   Run `docker-compose down` to stop and remove the containers (`app` and `db`).
    *   If you want to remove the database data volume as well (deleting all stored data), run `docker-compose down -v`.
