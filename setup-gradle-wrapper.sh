#!/bin/bash

# Define global variables
GRADLE_VERSION="7.2"

# Function to print log
print_log() {
    echo "LOG: $1"
}

# Function to check if Gradle is installed
check_gradle_installation() {
    print_log "Checking if Gradle is installed to ensure the build automation tool is available."
    if command -v gradle &> /dev/null; then
        echo "Gradle is installed, version: $(gradle --version)"
    else
        echo "Gradle is not installed, proceeding with manual setup..."
    fi
}

# Function to check if JAVA_HOME is set properly
check_java_home() {
    print_log "Checking JAVA_HOME to ensure Java SDK is correctly configured for Gradle to function."
    if [ -z "$JAVA_HOME" ]; then
        echo "JAVA_HOME is not set. Please set JAVA_HOME to your JDK's installation directory."
        echo "On Unix-like systems, you can set it by adding:"
        echo "export JAVA_HOME=/path/to/jdk"
        echo "to your shell configuration file (e.g., ~/.bashrc or ~/.zshrc) and then running:"
        echo "source ~/.bashrc"
        echo "or"
        echo "source ~/.zshrc"
        echo "On Windows, set it via:"
        echo "set JAVA_HOME=C:\\path\\to\\jdk"
        echo "in the Command Prompt or set it permanently through the Environment Variables in System Properties."
        exit 1
    else
        echo "JAVA_HOME is set to $JAVA_HOME"
        if [ ! -d "$JAVA_HOME" ]; then
            echo "The directory specified in JAVA_HOME does not exist: $JAVA_HOME"
            exit 1
        fi
    fi
}

# Function to create necessary directories
create_directories() {
    print_log "Creating directories for the Gradle wrapper to store its files."
    mkdir -p gradle/wrapper
    echo "Directories created."
}

# Function to download Gradle wrapper scripts and jar
download_gradle_files() {
    print_log "Downloading Gradle wrapper scripts and jar to ensure version control over the build tool."
    curl -L https://raw.githubusercontent.com/gradle/gradle/master/gradlew -o gradlew
    curl -L https://raw.githubusercontent.com/gradle/gradle/master/gradlew.bat -o gradlew.bat
    echo "Scripts downloaded."

    curl -L https://raw.githubusercontent.com/gradle/gradle/master/gradle/wrapper/gradle-wrapper.jar -o gradle/wrapper/gradle-wrapper.jar
    echo "Gradle Wrapper jar downloaded."
}

# Function to create gradle-wrapper.properties file
create_properties_file() {
    print_log "Creating gradle-wrapper.properties to specify the Gradle distribution URL."
    cat << EOF > gradle/wrapper/gradle-wrapper.properties
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\\://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
EOF
    echo "gradle-wrapper.properties file created."
}

# Function to make scripts executable
make_executable() {
    print_log "Making downloaded scripts executable to enable the use of the Gradle wrapper."
    chmod +x gradlew
    echo "gradlew script is now executable."
}

# Main function to orchestrate script execution
main() {
    check_gradle_installation
    check_java_home
    create_directories
    download_gradle_files
    create_properties_file
    make_executable
    echo "Gradle Wrapper has been set up successfully."
}

# Execute the main function
main
