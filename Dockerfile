FROM ubuntu
USER root
MAINTAINER johnp

# Update image
RUN apt-get update -y

# ASSIGN A WORKING DIRECTORY
RUN mkdir -p /root/workdir
RUN mkdir -p /root/workdir/log
WORKDIR /root/workdir

# ADDITIONAL FILES TO COPY IF ANY
COPY scripts/shell .
COPY scripts/load .
COPY scripts/build .
COPY scripts/test .
COPY scripts/delete .
COPY scripts/unload .

# Run the load entrypoint
ENTRYPOINT ["/root/workdir/shell"]
