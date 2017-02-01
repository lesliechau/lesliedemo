FROM ibmcom/swift-ubuntu:latest
MAINTAINER IBM Swift Engineering at IBM Cloud
LABEL Description="Linux Ubuntu 14.04 image with the Swift binaries"

# Linux OS utils
RUN apt-get update 

# <%= data/postgresql/system-library-install %>

WORKDIR $HOME

# Copy the application source code
COPY . $HOME

# Compile the application
RUN swift build --configuration release

# If in local debug mode instead run:
# RUN swift build

# We can replace this port with what the user wants
EXPOSE 8080

CMD .build/release/Server