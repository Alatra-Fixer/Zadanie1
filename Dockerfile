# -------- Etap 1: Budowanie aplikacji --------
FROM rust:1.75 as builder

# Zmienna środowiskowa z nazwą aplikacji
ENV APP_NAME=rust-weather-app

# Ustaw katalog roboczy wewnątrz kontenera
WORKDIR /usr/src/$APP_NAME

# Skopiuj pliki manifestu i zależności najpierw (optymalizacja cache)
COPY Cargo.toml Cargo.lock ./

# Stwórz pusty katalog src i dodaj tymczasowy plik main.rs,
# żeby skompilować zależności z cache'em
RUN mkdir src && echo "fn main() {}" > src/main.rs

# Kompilacja zależności (szybsze kolejne budowanie)
RUN cargo build --release && rm -f target/release/deps/$APP_NAME*

# Skopiuj pozostały kod źródłowy
COPY src ./src

# Kompilacja właściwej aplikacji
RUN cargo build --release

# -------- Etap 2: Mały finalny obraz --------
FROM debian:bullseye-slim

# Autor obrazu (zgodnie z OCI)
LABEL org.opencontainers.image.authors="Rafal Oleszczak"

# Instalacja potrzebnych bibliotek systemowych (minimalnie)
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

# Skopiuj binarkę z etapu build
COPY --from=builder /usr/src/rust-weather-app/target/release/rust-weather-app /usr/local/bin/app

# Ustaw port, na którym nasłuchuje aplikacja
EXPOSE 8080

# HEALTHCHECK — sprawdza czy aplikacja działa
HEALTHCHECK --interval=10s --timeout=3s CMD curl --fail http://localhost:8080 || exit 1

# Uruchom aplikację
CMD ["app"]
