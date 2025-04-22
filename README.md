# Final Project Group 6 - Tree Planting Management System

## Project Overview

This project is a Java application designed to manage tree planting activities in Oakland neighborhoods. It allows users (residents, volunteers, admins) to request trees, manage permits, schedule site visits, track plantings, and generate reports. The system uses a MySQL database to store data.

## Significant Files and Directories

*   **`/ddl.sql`**: Contains the SQL Data Definition Language (DDL) statements to create the database schema (tables, constraints, etc.).
*   **`/dml.sql`**: Contains the SQL Data Manipulation Language (DML) statements to populate the database with initial lookup data and sample test data.
*   **`/java-app/`**: The root directory for the Java application source code and Maven project configuration.
    *   **`src/main/java/`**: Contains the Java source code.
        *   **`DAO/`**: Data Access Object classes ([`AdminDAO.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/DAO/AdminDAO.java), [`TreeRequestDAO.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/DAO/TreeRequestDAO.java), [`UserDAO.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/DAO/UserDAO.java), [`PermitDAO.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/DAO/PermitDAO.java), [`VolunteerDAO.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/DAO/VolunteerDAO.java), etc.). These classes handle all interactions with the MySQL database.
        *   **`Model/`**: Plain Java Objects representing the data entities ([`User.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/Model/User.java), [`TreeRequest.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/Model/TreeRequest.java), [`TreeSpecies.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/Model/TreeSpecies.java), [`Volunteer.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/Model/Volunteer.java), etc.).
        *   **`tasks/`**: Java classes ([`TaskA.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskA.java), [`TaskB.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskB.java), [`TaskC.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskC.java), [`TaskDE.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskDE.java), [`TaskF.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskF.java), [`TaskG.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskG.java), [`TaskH.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskH.java), [`TaskI.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskI.java), [`TaskJ.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskJ.java), [`TaskK.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskK.java), [`TaskL_stored_procedure.java`](/Users/mac/MySQL/project-project-6/java-app/src/main/java/tasks/TaskL_stored_procedure.java)). Each class typically contains a `main` method to execute a specific application feature or workflow, often interacting with DAOs.
        *   **`util/DBConnection.java`**: Utility class for managing the database connection. Reads connection details from environment variables or potentially hardcoded values (should be configured via environment variables for Docker).

## How to Compile, Configure, and Run 

**Video Annotated Walkthrough** 
*  https://www.youtube.com/watch?v=nFkws1s8MGk

*   **`DockerSetUp`**: Defines the steps to build a Docker image for the Java application. This typically involves:
    1.  Using MySQL image in Docker.
    2.  Create a container and input port number, setting environment variables for `MYSQL_ROOT_PASSWORD` and set password to yes.
    3. Copy the root password for later use.
*   **`DataGripSetUp`**: 
    1.  Create a data source using root as user, inputing root passowrd and port number. 
    2.  Create databases `tree` and new user `tree.reporter`, generate password, grand all previlidges to `tree.reporter`.
    3.  Create a new data source using tree.reporter as user, input port number, specify to use the `tree` database, use the password generated from last step. 
    4.  Copy the url for later use.
*   **`JavaSetUp`**:
    1. cd to DBConnection.java
    2. use the url copied from last step, input user `tree.reporter` and password from last step.

**Demo Video**
*   Showing input/output examples of each of the tasks
*   https://drive.google.com/file/d/10XKWMuYhvIwlLVkSVgFAUnBmlkOWX1Zp/view?usp=sharing
