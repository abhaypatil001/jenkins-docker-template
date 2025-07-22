# 🧩 Troubleshooting Jenkins Docker Volume Issues on macOS

## ❗ Problem

When running the Jenkins container with a volume mapped to your macOS file system, you may see this error in the container logs:

touch: cannot touch '/var/jenkins_home/copy_reference_file.log': Permission denied
Can not write to /var/jenkins_home/copy_reference_file.log. Wrong volume permissions?


---

## ✅ Root Cause

Jenkins inside the container runs as **user ID 1000** (jenkins user), and the mounted host volume has ownership or permissions that prevent write access.

---

## 🔧 Solutions

### 1. 📂 Fix Permissions (Quick Fix)

Temporarily allow full access:

```bash
chmod -R 777 /Users/Abhay/Documents/Labs/jenkins_home

---

### 2. 👤 Fix Ownership (Recommended)
Give ownership to UID 1000:

```bash
sudo chown -R 1000:1000 /Users/Abhay/Documents/Labs/jenkins_home

