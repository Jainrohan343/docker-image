#Build this image on top of Ubuntu v14.04
#FROM ubuntu:14.04
FROM beevelop/cordova
MAINTAINER Swami
EXPOSE 3000
#Install curl, git, software-properties-common, python, nodejs, cordova
RUN \
apt-get update && \
apt-get install -y software-properties-common curl python git && \
curl https://nodejs.org/dist/v4.4.5/node-v4.4.5-linux-x64.tar.gz | tar xz -C /usr/local/ --strip=1 && \
npm install -g cordova@4.3.0

# - then it should create directory /usr/src/app for app files with 'mkdir -p /usr/src/app'
WORKDIR mkdir /usr/src/app
# - Node uses a "package manager", so it needs to copy in package.json file
COPY package.json package.json
# - then it needs to run 'npm install' to install dependencies from that file
RUN npm install 
# - to keep it clean and small, run 'npm cache clean --force' after above
RUN npm cache clean --force
# - then it needs to copy in all files from current directory
copy . .
# - then it needs to start container with command 'tini -- node ./bin/www'
# CMD["tini","--","node","./bin/www"]
#CMD [ "npm", "start" ]
RUN cordova platform add browser 
RUN cordova run browser
