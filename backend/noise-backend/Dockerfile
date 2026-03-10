# Stage 1: Build the Haskell application
FROM haskell:9.4 AS builder
# Update apt-sources in case of archived debian repositories, then install libpq-dev
RUN apt-get update --allow-releaseinfo-change || true \
    && apt-get install -y libpq-dev zlib1g-dev pkg-config

# Copy dependency files first to cache them
COPY stack.yaml package.yaml noise-backend.cabal ./
RUN stack build --only-dependencies

# Copy source code and build
COPY . .
RUN stack build --copy-bins --local-bin-path /app/bin

# Stage 2: Minimal runtime environment
FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y libgmp-dev ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app
# Copy the compiled binary
COPY --from=builder /app/bin/noise-backend-exe ./noise-backend
# IMPORTANT: Copy your dataset so the deployed app can read it
COPY dataset ./dataset 

EXPOSE 3000
CMD ["./noise-backend"]
