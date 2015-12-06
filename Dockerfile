FROM hypriot/rpi-python
MAINTAINER Rob Sharp <qnm@fea.st>

ENV DEBIAN_FRONTEND noninteractive

# Install CURL
RUN apt-get update
RUN apt-get install -y curl

# Note the sed hack to enable rpi2 support
RUN mkdir /pocketmine
RUN cd /pocketmine && curl -sL http://get.pocketmine.net/ | sed 's/2708/270\[89\]/g' | bash -s - -r -v development

# Grab a 1.6 phar
RUN curl --url "http://jenkins.pocketmine.net/job/PocketMine-MP-Bleeding/51/artifact/PocketMine-MP_1.6dev-51_mcpe-0.13_2ddc4455_API-1.13.0.phar" --output /pocketmine/PocketMine-MP.phar

VOLUME /pocketmine
WORKDIR /pocketmine

EXPOSE 19132

CMD ["./start.sh", "--no-wizard", "--enable-rcon=on"]

