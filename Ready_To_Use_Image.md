# 🐳 Jenkins Docker Image with Preinstalled Plugins and Docker Support

This Docker image is based on `jenkins/jenkins:lts` and comes with:

- Pre-installed Jenkins plugins
- Docker CLI
- Git
- Persistent volume support
- Jenkins setup wizard disabled for automation

---

## 🚀 How to Use

### 1. Pull the Image

```bash
docker pull abhaypatil001/jenkins-docker:v1
```

> Replace `abhaypatil001` with your actual Docker Hub username if different.

---

### 2. Prepare Persistent Storage

Create a persistent Jenkins data directory on your host machine:

```bash
mkdir -p ~/jenkins_home
sudo chown -R 1000:1000 ~/jenkins_home  # Important for Jenkins write access
```

For macOS:
```bash
chmod -R 777 ~/jenkins_home  # or fix via Docker Desktop → File Sharing
```

---

### 3. Run the Jenkins Container

```bash
docker run -d \
  --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ~/jenkins_home:/var/jenkins_home \
  abhaypatil001/jenkins-docker:v1
```

---

### 🔑 Access Jenkins UI

- URL: http://localhost:8080
- Username: abhay
- Password: admin123
- Jenkins will skip the setup wizard by default.
- Create an admin user manually or customize further with Groovy scripts.

---

## 🔧 Pre-installed Plugins

- `git`
- `docker-workflow`
- `blueocean`
- `workflow-aggregator`
- `credentials-binding`

---

## 📁 Troubleshooting

If you encounter volume permission issues (e.g. `Permission denied` in logs), refer to the [TROUBLESHOOTING.md](https://github.com/abhaypatil001/TROUBLESHOOTING.md) for full details.

---

## 📌 Notes

- Port `8080`: Jenkins Web UI
- Port `50000`: Jenkins agent-to-controller communication
- Image is designed for local development, CI testing, and plugin experimentation

---

## 👨‍💻 Maintainer

Abhay Patil  
GitHub: [@abhaypatil001](https://github.com/abhaypatil001)  
Docker Hub: [abhaypatil001](https://hub.docker.com/u/abhaypatil001)
