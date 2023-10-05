# Use the CentOS base image
FROM ubuntu:latest

USER root

WORKDIR /opt

RUN apt update && apt upgrade -y
RUN apt install sudo -y
RUN sudo apt install curl wget -y

RUN curl -s https://dl.openfoam.com/add-debian-repo.sh | sudo bash
RUN wget -q -O - https://dl.openfoam.com/add-debian-repo.sh | sudo bash
RUN sudo apt-get install openfoam2306-default -y

RUN sudo apt-get install ca-certificates vim -y
RUN sudo apt-get update -y


# Install Git, OpenSSH, python, etc.
RUN sudo apt-get install -y git openssh-client openssh-server python3

# create new user 
RUN useradd -ms /bin/bash ofuser
RUN echo "source /usr/lib/openfoam/openfoam2306/etc/bashrc" >> /home/ofuser/.bashrc

# Create the .ssh directory for the "ofuser" user
RUN mkdir -p /home/ofuser/.ssh && chown -R ofuser:ofuser /home/ofuser/.ssh

# Add your predefined SSH private key
COPY id_rsa /home/ofuser/.ssh/id_rsa
COPY id_rsa.pub /home/ofuser/.ssh/id_rsa.pub

# Set the correct permissions for the private key
RUN chmod 600 /home/ofuser/.ssh/id_rsa

RUN chown -R ofuser:ofuser /usr/lib/openfoam/openfoam2306 /home/ofuser/.ssh

USER ofuser

WORKDIR /usr/lib/openfoam/openfoam2306


RUN echo "# OpenFOAM-v2306" >> README.md
RUN git init
RUN git config --global --add safe.directory /usr/lib/openfoam/openfoam2306
RUN git add .
RUN git config --global user.email amani.ae87@gmail.com
RUN git config --global user.name ahmad
RUN git commit -m "first commit"
RUN git branch -M main
RUN git remote add origin git@github.com:Eirene2015/OpenFOAM-v2306.git
