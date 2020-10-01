FROM ubuntu
USER root
MAINTAINER johnp

# Update image
RUN apt-get update -y

# ASSIGN A WORKING DIRECTORY
RUN mkdir -p /root/workdir
RUN mkdir -p /root/workdir/log
WORKDIR /root/workdir

COPY scripts/ .

# Run the load entrypoint
ENTRYPOINT ["/root/workdir/shell"]
