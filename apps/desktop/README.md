# Desktop App Docker Build

This document explains how to build the Desktop application using Docker and extract the artifacts.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed on your machine.

## Building the Docker Image

Run the following command from the **root** of the repository:

```bash
docker build -f apps/desktop/Dockerfile -t devtools-desktop-builder .
```

This will create a Docker image named `devtools-desktop-builder` containing the necessary environment and source code.

## Running the Build and Extracting Artifacts

The container is configured to build the application and copy the artifacts to a specified output directory.

To build the app and output the files to a local `dist` folder:

```bash
# Ensure the local `dist` folder exists (optional, docker will create it, but permissions might vary)
mkdir -p dist

# Run the container, mounting the local directory to /dist (the default output path in container)
docker run --rm -v "$(pwd)/dist:/dist" devtools-desktop-builder
```

To specify a different output name or path:

```bash
docker run --rm -v "$(pwd)/my-custom-output:/output" devtools-desktop-builder /output
```

## Troubleshooting

- **Permission Issues**: usage of `docker run -v` might result in files owned by `root`. You can change ownership after the build:
  ```bash
  sudo chown -R $USER:$USER dist/
  ```
