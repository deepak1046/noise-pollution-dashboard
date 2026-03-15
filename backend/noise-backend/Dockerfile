# ─────────────────────────────────────────────────────────────────────────────
# Stage 1: Build
# Uses a pinned image matching lts-22.43 (GHC 9.6.6)
# ─────────────────────────────────────────────────────────────────────────────
FROM haskell:9.6 AS builder

# Install system libs needed to compile Haskell packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libgmp-dev zlib1g-dev pkg-config ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /build

# ── Dependency caching trick ──────────────────────────────────────────────────
# Copy ONLY the project description files first so Docker can cache this layer.
# Then create minimal stub source files so `stack build --only-dependencies`
# can resolve all transitive deps without real source code.
COPY stack.yaml package.yaml noise-backend.cabal ./

# Create stub source files so stack does not complain about missing modules
RUN mkdir -p app src && \
    echo 'module Main where\nmain :: IO ()\nmain = return ()' > app/Main.hs && \
    echo 'module Lib where' > src/Lib.hs

# Download + compile ONLY dependencies (cached as a separate Docker layer)
RUN stack build --only-dependencies --system-ghc 2>&1

# ── Full build ────────────────────────────────────────────────────────────────
# Now copy the real source and dataset
COPY . .

RUN stack build --copy-bins --local-bin-path /app/bin --system-ghc 2>&1

# ─────────────────────────────────────────────────────────────────────────────
# Stage 2: Minimal runtime image
# ─────────────────────────────────────────────────────────────────────────────
FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libgmp10 ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy compiled binary from builder stage
COPY --from=builder /app/bin/noise-backend-exe ./noise-backend

# Copy dataset so the app can read it at runtime
COPY --from=builder /build/dataset ./dataset

# Render injects PORT automatically; default to 3000 for local Docker runs
ENV PORT=3000
EXPOSE 3000

CMD ["./noise-backend"]
