# 🛠 TROUBLESHOOTING: Jenkins Docker Volume Permission Issue on macOS

This guide documents the issue faced when running a Jenkins container with a host-mounted persistent volume on macOS, and how it was resolved.

---

## 🧩 Problem Statement

After running the Jenkins Docker container with a mounted volume:

```bash
docker run -d \
  --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /Users/Abhay/Documents/Labs/jenkins_home:/var/jenkins_home \
  jenkins-docker:v1
```

The Jenkins UI was not loading properly, and the container logs showed the following error:

```
touch: cannot touch '/var/jenkins_home/copy_reference_file.log': Permission denied
Can not write to /var/jenkins_home/copy_reference_file.log. Wrong volume permissions?
```

---

## 🔍 Root Cause

Jenkins runs as user with UID `1000` inside the container (default for the `jenkins/jenkins:lts` image).

macOS file systems do not always respect Linux-style UID permission mappings when volumes are mounted, especially for non-system paths like `/Users/...`.

As a result, the container user `jenkins` could not write to the mounted volume.

---

## ✅ Solution: Fix Volume Permissions

### 🔧 Step-by-Step Fix

1. **Ensure the volume directory exists on host:**

```bash
mkdir -p /Users/Abhay/Documents/Labs/jenkins_home
```

2. **Grant ownership to UID 1000 (Jenkins user inside container):**

```bash
sudo chown -R 1000:1000 /Users/Abhay/Documents/Labs/jenkins_home
```

3. **If still fails, apply open permission (not recommended for production):**

```bash
chmod -R 777 /Users/Abhay/Documents/Labs/jenkins_home
```

---

## 🧪 Verification

Re-run the container:

```bash
docker run -d \
  --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /Users/Abhay/Documents/Labs/jenkins_home:/var/jenkins_home \
  jenkins-docker:v1
```

Check container logs:

```bash
docker logs -f jenkins
```

No more `Permission denied` errors should be observed, and Jenkins UI should be accessible at:

```
http://localhost:8080
```

---

## ⚙️ Additional Troubleshooting (macOS Docker Desktop)

### ✅ Ensure Path is Shared with Docker

1. Open **Docker Desktop**
2. Go to **Settings → Resources → File Sharing**
3. Add:

   ```
   /Users/Abhay/Documents/Labs/
   ```

4. Click **Apply & Restart**

---

## 🧼 Clean Up (Optional)

To reset the container:

```bash
docker stop jenkins && docker rm jenkins
rm -rf /Users/Abhay/Documents/Labs/jenkins_home
```

---

## 📝 Notes

- Jenkins persistent data (jobs, plugins, config) is stored in `/var/jenkins_home` inside the container
- Always ensure volume mounts are writable by UID 1000 for Jenkins containers
- Avoid using folders under Desktop or iCloud-synced locations to prevent Docker access issues

---

## 🧷 References

- Jenkins Official Docker Image: https://hub.docker.com/r/jenkins/jenkins
- Docker for Mac Volume Mount Permissions: https://docs.docker.com/desktop/mac/

---

**Documented by:** Abhay Patil  
**Last Updated:** July 2025
