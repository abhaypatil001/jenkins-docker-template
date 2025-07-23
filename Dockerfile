FROM jenkins/jenkins:lts

# Skip setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

USER root

# Install docker CLI and git
RUN apt-get update && \
    apt-get install -y git docker.io && \
    apt-get clean

# Add Jenkins user to Docker group
RUN usermod -aG docker jenkins

# Switch back to Jenkins user
USER jenkins

# Install plugins from plugins.txt
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Copy init scripts
COPY init.groovy.d/ /usr/share/jenkins/ref/init.groovy.d/ 

