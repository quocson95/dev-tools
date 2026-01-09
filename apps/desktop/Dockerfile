# Base Image
FROM ubuntu:20.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install common build dependencies and tools
RUN apt-get update && apt-get install -y \
  curl \
  wget \
  git \
  build-essential \
  python3 \
  libvips-dev \
  libxml2-dev \
  libicns-dev \
  libssl-dev \
  libgtk-3-dev \
  libgbm-dev \
  libnotify-dev \
  libgconf-2-4 \
  libnss3 \
  libxss1 \
  libasound2 \
  libxtst6 \
  xauth \
  xvfb \
  fuse \
  libfuse2 \
  file \
  jq \
  && rm -rf /var/lib/apt/lists/*

# Install Go 1.25
RUN wget -q https://go.dev/dl/go1.25.5.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go1.25.5.linux-amd64.tar.gz && \
  rm go1.25.5.linux-amd64.tar.gz

ENV GOPATH=/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Install Node.js 22.x
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
  apt-get install -y nodejs

# Install pnpm
RUN npm install -g pnpm

# Set working directory
WORKDIR /app

# We need the full context because of workspace dependencies (packages/*, apps/*)
COPY . .

# Install dependencies
# Install dependencies
# We use --no-frozen-lockfile to avoid issues if the lockfile state vs catalog doesn't perfectly match the container pnpm version
ENV CI=true
RUN --mount=type=cache,target=/root/.local/share/pnpm/store pnpm install --no-frozen-lockfile

# Install requested Go tools
RUN go install connectrpc.com/connect/cmd/protoc-gen-connect-go@latest \
  && go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest \
  && go install google.golang.org/protobuf/cmd/protoc-gen-go@latest \
  && go install github.com/go-task/task/v3/cmd/task@latest

# RUN pnpm nx run desktop:build

# Copy the entrypoint script
COPY ./apps/desktop/entrypoint.sh ./entrypoint.sh
RUN chmod +x entrypoint.sh

# Set the entrypoint to the script
ENTRYPOINT ["./entrypoint.sh"]

# Default argument for the output directory (can be overridden)
CMD ["/dist"]
