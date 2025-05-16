---

## 1. Plik `Dockerfile`

Użyto wieloetapowego budowania obrazu Dockera:

* **Etap 1:** kompilacja kodu Rust (`cargo build --release`).
* **Etap 2:** lekki finalny obraz z `debian:bullseye-slim` (dla HTTPS).
* Dodano **healthcheck**, ekspozycję portu `8080`, oraz metadane autora zgodne ze specyfikacją OCI.

---

## 2. Obsługa projektu – polecenia

### a. Budowanie obrazu Dockera:

```bash
docker build -t rust-weather-app .
```

### b. Uruchomienie kontenera:

```bash
docker run -d -p 8080:8080 --name pogoda rust-weather-app
```

### c. Uzyskanie logów aplikacji:

```bash
docker logs pogoda
```


### d. Sprawdzenie liczby warstw i rozmiaru obrazu:

```bash
docker history rust-weather-app
docker images rust-weather-app
```

---
