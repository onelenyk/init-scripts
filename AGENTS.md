# AI Agent Integration Guide

## Project Overview
This is a starter pack with Gradle initialization scripts to create various project types automatically.

## Files and Functions

### `init-gradle-project.sh`
**Purpose**: Initialize Gradle projects with command-line parameters, avoiding interactive mode
**API**:
- `--type [project-type]`: Project type (basic, java-application, kotlin-application, etc.)
- `--dsl [kotlin|groovy]`: DSL type for build files
- `--test-framework [junit|junit-jupiter|testng|spock|scalatest|kotlintest]`: Testing framework
- `--project-name [name]`: Project name
- `--package [package]`: Package name for source files
- `--java-version [version]`: Java version (8, 11, 17, 21)
- `--split-project / --no-split-project`: Split functionality across subprojects?
- `--overwrite / --no-overwrite`: Overwrite existing files?
- `--comments / --no-comments`: Include clarifying comments?
- `--incubating / --no-incubating`: Use incubating APIs?
- `--insecure-protocol [fail|warn|upgrade]`: Handle insecure URLs

**Return**: Exit code 0 on success, non-zero on failure

### `create-gradle-project.sh`
**Purpose**: Convenience script to create preset project types
**API**:
- `cli-app [project-name] [additional-options...]`: Create Kotlin CLI application
- `java-app [project-name] [additional-options...]`: Create Java application
- `java-lib [project-name] [additional-options...]`: Create Java library
- `kotlin-app [project-name] [additional-options...]`: Create Kotlin application
- `kotlin-lib [project-name] [additional-options...]`: Create Kotlin library
- `gradle-plugin [project-name] [additional-options...]`: Create Java Gradle plugin
- `basic [project-name] [additional-options...]`: Create basic Gradle build

**Return**: Exit code 0 on success, non-zero on failure

## System Requirements
- Bash shell
- Java runtime
- Network access (for Gradle dependency downloads)

## Execution Notes
- Both scripts use `--no-daemon` to prevent hanging processes
- Scripts call `./gradlew --stop` to terminate any remaining daemons
- Output from Gradle is displayed in real-time
- All parameters from command line are passed through with `"$@"`

## Interaction Flow
1. Agent calls script with parameters
2. Script builds Gradle command with parameters
3. Script executes `yes | gradlew init` or `echo "" | gradlew init` to handle prompts
4. Script captures exit code
5. Script runs `./gradlew --stop` to clean up daemons
6. Script exits with original Gradle exit code

## Expected Exit Codes
- 0: Success
- 1: General failure
- Other: Gradle-specific error codes