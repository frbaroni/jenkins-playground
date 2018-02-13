FROM jenkins/jenkins
ARG HOST_DOCKER_GROUPID
USER root

# Update
RUN apt-get update

# Install dependencies
RUN apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

RUN echo "HOST_DOCKER_GROUPID=$HOST_DOCKER_GROUPID" && groupadd docker -g $HOST_DOCKER_GROUPID
RUN usermod -aG docker jenkins

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"
RUN apt-get update && apt-get install -y docker-ce

# Drop back to the regular jenkins user - good practice
USER jenkins
