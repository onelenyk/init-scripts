# Starter Pack

This is a starter pack for creating Gradle projects with helpful automation scripts.

## Files

### Core Gradle Wrapper Files
- **`gradlew`** - Unix/Linux/macOS wrapper script for executing Gradle commands without requiring a local Gradle installation
- **`gradlew.bat`** - Windows batch script for executing Gradle commands without requiring a local Gradle installation  
- **`gradle/wrapper/gradle-wrapper.properties`** - Configuration file specifying the Gradle version used for the project
- **`gradle/wrapper/gradle-wrapper.jar`** - JAR file containing the Gradle wrapper implementation

### Project Scripts
- **`init-gradle-project.sh`** - Bash script that wraps the `gradlew init` command with specified parameters and handles interactive mode automatically. It accepts various command-line options like `--type`, `--dsl`, `--test-framework`, etc., and runs Gradle in a non-interactive way to prevent hanging processes.

- **`create-gradle-project.sh`** - Convenience script that provides preset configurations for creating common project types (Kotlin app, Java app, library, etc.) by calling the `init-gradle-project.sh` script with appropriate parameters.

### Configuration Files
- **`.gitignore`** - Specifies intentionally untracked files that Git should ignore (typically build artifacts, IDE files, etc.)
- **`.gitattributes`** - Defines attributes per path for Git to handle files with special characteristics (like line endings)

### Setup
- **`setup-gradle-wrapper.sh`** - Script to set up the Gradle wrapper in a project

### Project Files
- **`build.gradle`/`build.gradle.kts`** - Gradle build script file (if exists) that defines the project's build configuration
- **`settings.gradle`/`settings.gradle.kts`** - Gradle settings file (if exists) that defines the project name and includes subprojects if it's a multi-project build

### Directories
- **`.gradle/`** - Directory where Gradle stores cache data and temporary files
- **`src/`** - Source code directory (typically contains main and test source code)

## Usage

### Creating a New Project

To create a Kotlin application:
```bash
./create-gradle-project.sh kotlin-app my-app-name
```

To create a Java application:
```bash
./create-gradle-project.sh java-app my-app-name
```

For more options:
```bash
./create-gradle-project.sh --help
```

### Direct Usage

To use the init script directly:
```bash
./init-gradle-project.sh --type kotlin-application --project-name my-app --dsl kotlin --test-framework junit-jupiter
```

### Available Project Types

The `create-gradle-project.sh` script supports these project types:
- `cli-app` - Command Line Application (Java)
- `java-app` - Java Application
- `java-lib` - Java Library
- `kotlin-app` - Kotlin Application
- `kotlin-lib` - Kotlin Library
- `gradle-plugin` - Gradle Plugin (Java)
- `basic` - Basic Gradle build

## Features

- **Non-interactive Execution**: The scripts handle interactive prompts automatically using input redirection
- **Real-time Output**: Shows Gradle's output during execution (no suppressed logs)
- **Proper Cleanup**: Ensures Gradle daemons are stopped after execution
- **Error Handling**: Captures and reports exit codes properly
- **Flexible Parameters**: Supports all standard Gradle init parameters