FROM node:20.3.0-alpine3.17

WORKDIR /app

COPY ../client/package.json ./
COPY ../client/package-lock.json ./

RUN npm install

COPY ../client/ ./client/

EXPOSE 3000