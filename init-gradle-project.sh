#!/bin/bash

# Script to run gradlew init with specified parameters and avoid interactive mode
# Usage: ./init-gradle-project.sh [init options]

set -e  # Exit immediately if a command exits with a non-zero status

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo_colored() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

print_usage() {
    echo_colored $YELLOW "Usage: $0 [OPTIONS]"
    echo_colored $YELLOW "Options:"
    echo_colored $YELLOW "  --type [basic|pom|maven-conversion|java-application|java-library|java-gradle-plugin|kotlin-application|kotlin-library|kotlin-gradle-plugin|groovy-application|groovy-library|groovy-gradle-plugin|scala-application|scala-library|cpp-application|cpp-library|swift-application|swift-library]"
    echo_colored $YELLOW "  --dsl [groovy|kotlin]"
    echo_colored $YELLOW "  --test-framework [junit|junit-jupiter|testng|spock|scalatest|kotlintest]"
    echo_colored $YELLOW "  --project-name [project name]"
    echo_colored $YELLOW "  --package [package name]"
    echo_colored $YELLOW "  --java-version [version number like 8|11|17|21]"
    echo_colored $YELLOW "  --split-project / --no-split-project  Split functionality across multiple subprojects?"
    echo_colored $YELLOW "  --overwrite / --no-overwrite  Overwrite existing files?"
    echo_colored $YELLOW "  --comments / --no-comments  Include clarifying comments in files"
    echo_colored $YELLOW "  --incubating / --no-incubating  Use incubating APIs"
    echo_colored $YELLOW "  --insecure-protocol [fail|warn|upgrade]  How to handle insecure URLs"
    echo_colored $YELLOW "  -h, --help    Show this help message"
    echo_colored $YELLOW ""
    echo_colored $YELLOW "Example: $0 --type java-application --dsl kotlin --test-framework junit-jupiter --project-name my-app --java-version 17"
}

# Initialize variables
INIT_TYPE=""
DSL_TYPE=""
TEST_FRAMEWORK=""
PROJECT_NAME=""
PACKAGE_NAME=""
JAVA_VERSION=""
SPLIT_PROJECT=""
OVERWRITE=""
COMMENTS=""
INCUBATING=""
INSECURE_PROTOCOL=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --type)
            INIT_TYPE="$2"
            shift 2
            ;;
        --dsl)
            DSL_TYPE="$2"
            shift 2
            ;;
        --test-framework)
            TEST_FRAMEWORK="$2"
            shift 2
            ;;
        --project-name)
            PROJECT_NAME="$2"
            shift 2
            ;;
        --package)
            PACKAGE_NAME="$2"
            shift 2
            ;;
        --split-project)
            SPLIT_PROJECT="--split-project"
            shift
            ;;
        --no-split-project)
            SPLIT_PROJECT="--no-split-project"
            shift
            ;;
        --java-version)
            JAVA_VERSION="$2"
            shift 2
            ;;
        --overwrite)
            OVERWRITE="--overwrite"
            shift
            ;;
        --no-overwrite)
            OVERWRITE="--no-overwrite"
            shift
            ;;
        --comments)
            COMMENTS="--comments"
            shift
            ;;
        --no-comments)
            COMMENTS="--no-comments"
            shift
            ;;
        --incubating)
            INCUBATING="--incubating"
            shift
            ;;
        --no-incubating)
            INCUBATING="--no-incubating"
            shift
            ;;
        --insecure-protocol)
            INSECURE_PROTOCOL="$2"
            shift 2
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            echo_colored $RED "Unknown option: $1"
            print_usage
            exit 1
            ;;
    esac
done

echo_colored $GREEN "Gradle Project Initialization Script"
echo_colored $GREEN "====================================="

# Build the gradle init command
GRADLE_CMD="./gradlew --no-daemon init"
if [[ -n "$INIT_TYPE" ]]; then
    GRADLE_CMD="$GRADLE_CMD --type $INIT_TYPE"
fi
if [[ -n "$DSL_TYPE" ]]; then
    GRADLE_CMD="$GRADLE_CMD --dsl $DSL_TYPE"
fi
if [[ -n "$TEST_FRAMEWORK" ]]; then
    GRADLE_CMD="$GRADLE_CMD --test-framework $TEST_FRAMEWORK"
fi
if [[ -n "$PROJECT_NAME" ]]; then
    GRADLE_CMD="$GRADLE_CMD --project-name $PROJECT_NAME"
fi
if [[ -n "$PACKAGE_NAME" ]]; then
    GRADLE_CMD="$GRADLE_CMD --package $PACKAGE_NAME"
fi
if [[ -n "$JAVA_VERSION" ]]; then
    GRADLE_CMD="$GRADLE_CMD --java-version $JAVA_VERSION"
fi
if [[ -n "$SPLIT_PROJECT" ]]; then
    GRADLE_CMD="$GRADLE_CMD $SPLIT_PROJECT"
fi
if [[ -n "$OVERWRITE" ]]; then
    GRADLE_CMD="$GRADLE_CMD $OVERWRITE"
fi
if [[ -n "$COMMENTS" ]]; then
    GRADLE_CMD="$GRADLE_CMD $COMMENTS"
fi
if [[ -n "$INCUBATING" ]]; then
    GRADLE_CMD="$GRADLE_CMD $INCUBATING"
fi
if [[ -n "$INSECURE_PROTOCOL" ]]; then
    GRADLE_CMD="$GRADLE_CMD --insecure-protocol $INSECURE_PROTOCOL"
fi

# Execute gradle init command without --quiet to show all output
GRADLE_CMD="$GRADLE_CMD"

echo_colored $YELLOW "Executing command: $GRADLE_CMD"
echo_colored $YELLOW "Interactive prompts will be bypassed. Gradle output will be shown."

# Run the gradle init command with input redirection to prevent interactive prompts
# Use echo with an empty response to stdin, or use yes command to auto-answer prompts
echo_colored $GREEN "Running Gradle init..."

# Run with a single echo to respond to potential first prompt
echo "" | $GRADLE_CMD
EXIT_CODE=$?

# If the initial attempt with echo failed, run without input redirection
if [ $EXIT_CODE -ne 0 ]; then
    $GRADLE_CMD
    EXIT_CODE=$?
fi

# Stop any remaining Gradle daemons to prevent hanging processes
./gradlew --stop

echo_colored $YELLOW "Gradle command exit code: $EXIT_CODE"

if [ $EXIT_CODE -eq 0 ]; then
    echo_colored $GREEN "Gradle project initialized successfully!"
else
    echo_colored $RED "Gradle init failed. Please check the output above for details."
    exit $EXIT_CODE
fi