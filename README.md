# 🧰 Jenkins Custom Docker Image with Persistent Storage and Plugins

This project builds a custom Jenkins Docker image with:

- Pre-installed plugins
- Docker CLI and Git inside the container
- Persistent storage (bind-mounted from host)
- Volume mount for `/var/run/docker.sock` to allow Docker-in-Docker
- Skipped setup wizard for automated initialization

---

## 📦 Included Jenkins Plugins

The following plugins are automatically installed via `plugins.txt`:

- git
- docker-workflow
- blueocean
- workflow-aggregator
- credentials-binding

---

## 🛠️ Prerequisites

- Docker installed on your host system
- Internet access to pull Jenkins base image and plugins

---

## 📁 Folder Structure
├── Dockerfile
├── plugins.txt
└── README.md


---

## 🐳 Build the Docker Image

```bash
docker build -t my-jenkins-docker:latest .


---

## 🗂️ Prepare Persistent Storage Directory

Jenkins stores job configs, plugin data, credentials, and more in `/var/jenkins_home`.

---

## To persist this data outside the container:

```bash
mkdir -p ~/jenkins_home
sudo chown -R 1000:1000 ~/jenkins_home

---

## 🐳 Build the Jenkins Docker Image

```bash
docker build -t my-jenkins-docker:latest .


---

## 🚀 Run Jenkins Container

```bash
docker run -d \
  --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ~/jenkins_home:/var/jenkins_home \
  my-jenkins-docker:latest

---

## 🌐 Access Jenkins

```bash
http://localhost:8080

---

## 🧼 Reset or Re-run Jenkins (Optional)


If you want to reset Jenkins (e.g., after testing):
```bash
docker rm -f jenkins
rm -rf ~/jenkins_home
mkdir -p ~/jenkins_home
sudo chown -R 1000:1000 ~/jenkins_home

Then run the container again with the docker run command above.


---

## 📌 Notes

The image disables the setup wizard (JAVA_OPTS=-Djenkins.install.runSetupWizard=false)

Plugins are installed during the first startup

Docker and Git are installed in the image so Jenkins jobs can run containerized builds



## 🧼 If you are looking to mount on specific path

docker run -d \
  --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /Users/Abhay/Documents/Labs/jenkins_home:/var/jenkins_home \
  jenkins-docker:v1

Note: make sure you run the command: "chmod -R 777 /Users/Abhay/Documents/Labs/jenkins_home" before running above command else the storage mount will give and issue.


