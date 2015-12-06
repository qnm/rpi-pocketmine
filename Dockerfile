FROM hypriot/rpi-python
MAINTAINER Rob Sharp <qnm@fea.st>

ENV DEBIAN_FRONTEND noninteractive

# Install CURL
RUN apt-get update
RUN apt-get install -y curl

# Note the sed hack to enable rpi2 support
RUN mkdir /pocketmine
RUN cd /pocketmine && curl -sL http://get.pocketmine.net/ | sed 's/2708/270\[89\]/g' | bash -s - -r -v development

VOLUME /pocketmine
WORKDIR /pocketmine

EXPOSE 19132

CMD ["./start.sh", "--no-wizard", "--enable-rcon=on"]

