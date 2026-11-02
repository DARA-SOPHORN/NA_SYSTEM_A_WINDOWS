# NA_SYSTEM_A (Windows)

Admin and client are Flutter web apps served by nginx; the api is FastAPI. Docker Compose runs all three.

| Service | URL | Folder |
|---|---|---|
| admin | http://localhost | `admin/` |
| client | http://localhost:81 | `client/` |
| api | http://localhost:8000/docs | `server/api/` |

## Install

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (includes `docker compose`)
- [Git for Windows](https://git-scm.com/download/win)
- [Flutter](https://docs.flutter.dev/get-started/install/windows) (only needed to change admin or client)
- VS Code with the **Container Tools** extension

## Run

Start Docker Desktop, then in the project folder:

```
docker compose up -d --build
```

In VS Code you can also click **Run All Services** or **Run Service** above a service in `docker-compose.yml`; the page opens in the browser when the service is up.

Stop everything:

```
docker compose down
```

## Change admin or client

Edit `admin/lib/main.dart` (or `client/lib/main.dart`), then rebuild:

```
cd admin
flutter build web
cd ..
docker compose up -d --build admin
```

## Troubleshooting

- **Port 80 is already in use**: another program (often IIS or Skype) is using it. Stop that program, or change `"80:80"` to `"8080:80"` in `docker-compose.yml` and open http://localhost:8080.
- **Old page still shows**: press `Ctrl + F5` in the browser.
