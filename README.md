# OTUS C++ Course Template Repository

[![CI/CD Pipeline](https://github.com/mnartov/otus-cpp-template/actions/workflows/build.yml/badge.svg)](https://github.com/mnartov/otus-cpp-template/actions/workflows/build.yml)

Template repository for OTUS C++ Professional course homeworks with built-in build system and CI/CD.

## Quick Start

### Build and Run

The repository includes `run.sh` script that handles all build and execution steps:

```bash
# Run the application (default)
./tools/run.sh

# Run unit tests
./tools/run.sh --test

# Clean build and run tests
./tools/run.sh --test --clean