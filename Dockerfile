# Primero instalar  Node js
FROM node:lts-alpine
#Despues instalams Json-server

RUN npm install -g http-server
RUN npm install -g json-server
WORKDIR /app
COPY package*.json ./
#Despues instalamos las dependencias
RUN npm install
COPY . .
RUN npm run build
EXPOSE 8087
CMD [ "http-server","json-server", "dist" ]
