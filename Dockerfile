FROM ubuntu:xenial
MAINTAINER pizycki

# Port Raven Studio will be hosted
EXPOSE 8080

ADD http://hibernatingrhinos.com/downloads/ravendb%20for%20ubuntu%2016.04%20x64/40006-alpha /home/Raven.tar.bz2

# Prepare container and Extract RavenDB files to directory
RUN apt-get update \
    && apt-get install -y \
    && apt-get install bzip2 -y \
    && apt-get install apt-transport-https -y \
    && cd /home \
    && mkdir Raven \
    && tar xf Raven.tar.bz2 -C Raven

# Install DotNet Core
RUN sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list' \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893 \
    && apt-get update \
    && apt-get install dotnet-dev-1.0.0-preview2.1-003177 -y

WORKDIR /home/Raven/Server
CMD ./Raven.Server