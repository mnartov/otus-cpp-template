#!/bin/bash

# Run the app or unit-tests
# Using: ./tools/run.sh [--test|--app] [--clean]

set -e

REPO_ROOT="$(git rev-parse --show-toplevel)"    # Repo path
BUILD_DIR="${REPO_ROOT}/build"                  # Build artifacts path
MODE="--app"                                    # Default mode
CLEAN=false                                     # By default not clean artifacts
PROJECT_NAME="master"                         # Name of homework app

# Parsing args
while [[ $# -gt 0 ]]; do
    case $1 in
        --test) MODE="--test"; shift ;;
        --app) MODE="--app"; shift ;;
        --clean) CLEAN=true; shift ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done

# Cleaning artifacts
if [ "$CLEAN" = true ]; then
    echo "Cleaning build artifacts..."
    rm -rf "${BUILD_DIR}"
    rm -f "${REPO_ROOT}/include/version.h"
fi

# Initializing submodules
if [[ $MODE == "--test" ]]; then
    echo "Initializing submodules..."
    (cd "${REPO_ROOT}" && git submodule update --init --recursive)
fi

# Building
mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

# Configuring
if [[ $MODE == "--test" ]]; then
    echo "Configuring in TEST mode"
    cmake "${REPO_ROOT}" -DBUILD_GTEST=ON
else
    echo "Configuring in APP mode"
    cmake "${REPO_ROOT}" -DBUILD_GTEST=OFF
fi

make -j$(nproc)

# Running
case $MODE in
    --test)
        echo "=== Running ${PROJECT_NAME} unit tests ==="
        ctest --output-on-failure
        ;;
    --app)
        EXECUTABLE="${BUILD_DIR}/src/${PROJECT_NAME}"
        if [ -f "${EXECUTABLE}" ]; then
            echo "=== Running ${PROJECT_NAME} app ==="
            "${EXECUTABLE}"
        else
            echo "Error: Executable not found at ${EXECUTABLE}"
            echo "Available files in build/src/:"
            ls -l "${BUILD_DIR}/src/" || true
            exit 1
        fi
        ;;
esac