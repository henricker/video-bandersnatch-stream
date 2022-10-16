FROM node:alpine

WORKDIR /home/app

RUN apk add --no-cache ffmpeg
RUN npm config set cache /tmp --global

COPY package.json .
COPY package-lock.json .
RUN npm install

COPY . .
