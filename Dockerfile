FROM node:alpine
USER root
WORKDIR /home/app
RUN apk add --no-cache ffmpeg
RUN npm config set cache /tmp --global

COPY package.json .
COPY package-lock.json .
RUN npm install

COPY . .

RUN chmod 777 /home/app
RUN chown -R root:root /home/app

RUN ./script.sh
