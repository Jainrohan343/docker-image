#Build this image on top of Ubuntu v14.04

FROM ubuntu:18.04

#MAINTAINER Rohan & Rupesh
EXPOSE 3000
#Install curl, git, software-properties-common, python, nodejs, cordova
RUN \
apt-get update && \
apt-get install -y software-properties-common curl python git && \
curl https://nodejs.org/dist/v4.4.5/node-v4.4.5-linux-x64.tar.gz | tar xz -C /usr/local/ --strip=1 && \
npm install -g cordova
RUN \
apt-get install apache2 -y


WORKDIR mkdir /usr/src/app



# - Node uses a "package manager", so it needs to copy in package.json file

COPY package.json package.json



# - then it needs to run 'npm install' to install dependencies from that file

RUN npm install



# - to keep it clean and small, run 'npm cache clean --force' after above

RUN npm cache clean --force



# - then it needs to copy in all files from current directory

copy . .

Run /etc/init.d/apache2 stop

RUN rm -rf  /var/www/html

#Run cd www

RUN yes | cp -rf www/ /var/www/html

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

#Run /etc/init.d/apache2 start
CMD apachectl -D FOREGROUND
#CMD["service","apache2","restart"]
#RUN cordova platform add browser

#CMD ["cordova", "run", "browser"]
