# 🚀 Space Explorer Logbook - DevOps Task

This project is a simple web application based on **Flask**. Its purpose is to serve as a test environment for configuring **CI/CD** pipelines and deploying to **Kubernetes**. The application uses **PostgreSQL** to store records (discovered planets) and **Redis** for a visit/action counter.

---

## 🎯 Your Task

As a DevOps Engineer, your goal is to prepare the infrastructure for this application:

1. **Kubernetes Deployment**: Prepare the deployment configuration using either plain **Kubernetes Manifests** (in a `k8s/` directory), **Kustomize**, or a **Helm Chart**. The configuration must include:
   - PostgreSQL Database (Deployment, Service, PVC if necessary).
   - Redis (Deployment, Service).
   - Flask application (Deployment, Service).
   - *Optional*: ConfigMap and Secrets for passing environment variables, and an Ingress.

2. **CI/CD Pipeline**: Configure a pipeline file (e.g., `.gitlab-ci.yml`) that should:
   - Run unit tests (see `pytest` below).
   - Build the Docker image using `app/Dockerfile`.
   - Push the image to a Container Registry.
   - Deploy the new version of the application to a Kubernetes cluster.

---

## ⚙️ Environment Variables

The application expects the following environment variables (see `docker-compose.yml` for an example):

| Variable | Description | Default in code |
|----------|-------------|-----------------|
| `DATABASE_URL` | PostgreSQL connection string | `postgresql://postgres:postgres@db:5432/space_logbook` |
| `REDIS_HOST` | Redis server hostname | `redis` |
| `REDIS_PORT` | Redis server port | `6379` |

> **Note:** The application features a "Graceful degradation" mechanism — it won't critically crash if the DB or Redis are initially unavailable (errors will appear in the logs), but its core functionality won't work. Your task in k8s is to configure the correct startup order or implement Readiness/Liveness probes.

---

## 🐳 Running Locally (for testing)

The project includes a `docker-compose.yml` file, which allows you to quickly spin up all services locally:
```bash
docker-compose up --build -d
```
Once started, navigate to **http://localhost:5001** in your web browser.

---

## 🧪 Running Tests (for CI/CD)

A basic test file `test_app.py` is provided in the `app` directory. It verifies the availability of the main page and the logic for adding records (using mocks for the databases).

Commands to run the tests locally:
```bash
cd app
pip install -r requirements.txt
pytest test_app.py -v
```
Use `pytest` as a step in your CI/CD pipeline to ensure code quality before building the image.
