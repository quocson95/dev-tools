#!/bin/bash
set -e

# The first argument is the target directory for artifacts
TARGET_DIR="${1:-/dist}"

echo "Starting Build Process..."
echo "Target Output Directory: $TARGET_DIR"

# Execute the build
pnpm nx run desktop:build

# Define the source directory where electron-builder outputs artifacts
# Relative to WORKDIR /app
SOURCE_DIR="apps/desktop/dist"

if [ -d "$SOURCE_DIR" ]; then
    echo "----------------------------------------------------------------"
    echo "✅ Build Successful."
    echo "Copying artifacts from '$SOURCE_DIR' to '$TARGET_DIR'..."

    # Ensure target directory exists
    mkdir -p "$TARGET_DIR"

    # Copy artifacts
    cp -r "$SOURCE_DIR"/* "$TARGET_DIR/"

    echo "Artifacts available in '$TARGET_DIR'"
    echo "----------------------------------------------------------------"
else
    echo "❌ Error: Build artifacts not found at '$SOURCE_DIR'"
    exit 1
fi
