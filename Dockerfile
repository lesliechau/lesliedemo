FROM ibmcom/swift-ubuntu:latest
MAINTAINER IBM Swift Engineering at IBM Cloud
LABEL Description="Template Dockerfile that extends the ibmcom/swift-ubuntu:latest image."

# We can replace this port with what the user wants
# EXPOSE {{PORT}}
EXPOSE 8080 9090

# Linux OS utils
RUN apt-get update

# <%= data/postgresql/system-library-install %>

WORKDIR /root/project

COPY . /root/project

ENTRYPOINT ["bash", "/root/utils/build-utils.sh", "/root/project"]
