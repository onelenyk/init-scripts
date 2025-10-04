#!/bin/bash

# Script to create specific Gradle projects using the init-gradle-project.sh script
# This script demonstrates how to use the main script with predefined configurations

set -e  # Exit immediately if a command exits with a non-zero status

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo_colored() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

print_usage() {
    echo_colored $YELLOW "Usage: $0 [project-type] [project-name] [optional parameters]"
    echo_colored $YELLOW "Project Types:"
    echo_colored $YELLOW "  java-app     - Java Application"
    echo_colored $YELLOW "  java-lib     - Java Library" 
    echo_colored $YELLOW "  kotlin-app   - Kotlin Application"
    echo_colored $YELLOW "  kotlin-lib   - Kotlin Library"
    echo_colored $YELLOW "  gradle-plugin - Gradle Plugin (Java)"
    echo_colored $YELLOW "  basic        - Basic Gradle build"
    echo_colored $YELLOW ""
    echo_colored $YELLOW "Note: Gradle output will be displayed during project creation."
    echo_colored $YELLOW ""
    echo_colored $YELLOW "Example: $0 java-app my-java-app --java-version 17 --test-framework junit-jupiter"
}

# Check if init-gradle-project.sh exists
if [ ! -f "./init-gradle-project.sh" ]; then
    echo_colored $RED "Error: init-gradle-project.sh not found in current directory"
    exit 1
fi

if [ $# -lt 2 ]; then
    print_usage
    exit 1
fi

PROJECT_TYPE=$1
PROJECT_NAME=$2
shift 2

echo_colored $GREEN "Creating Gradle project"
echo_colored $GREEN "======================="

case $PROJECT_TYPE in
    "java-app")
        echo_colored $BLUE "Creating Java Application project: $PROJECT_NAME"
        ./init-gradle-project.sh --type java-application --project-name "$PROJECT_NAME" --dsl kotlin --test-framework junit-jupiter "$@"
        ;;
    "java-lib")
        echo_colored $BLUE "Creating Java Library project: $PROJECT_NAME"
        ./init-gradle-project.sh --type java-library --project-name "$PROJECT_NAME" --dsl kotlin --test-framework junit-jupiter "$@"
        ;;
    "kotlin-app")
        echo_colored $BLUE "Creating Kotlin Application project: $PROJECT_NAME"
        ./init-gradle-project.sh --type kotlin-application --project-name "$PROJECT_NAME" --dsl kotlin --test-framework junit-jupiter "$@"
        ;;
    "kotlin-lib")
        echo_colored $BLUE "Creating Kotlin Library project: $PROJECT_NAME"
        ./init-gradle-project.sh --type kotlin-library --project-name "$PROJECT_NAME" --dsl kotlin --test-framework junit-jupiter "$@"
        ;;
    "gradle-plugin")
        echo_colored $BLUE "Creating Gradle Plugin project: $PROJECT_NAME"
        ./init-gradle-project.sh --type java-gradle-plugin --project-name "$PROJECT_NAME" --dsl kotlin --test-framework junit-jupiter "$@"
        ;;
    "basic")
        echo_colored $BLUE "Creating Basic Gradle project: $PROJECT_NAME"
        ./init-gradle-project.sh --type basic --project-name "$PROJECT_NAME" --dsl kotlin "$@"
        ;;
    *)
        echo_colored $RED "Unknown project type: $PROJECT_TYPE"
        print_usage
        exit 1
        ;;
esac

echo_colored $GREEN "Project $PROJECT_NAME has been created successfully!"