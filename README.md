
## Obsługa projektu – polecenia

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
