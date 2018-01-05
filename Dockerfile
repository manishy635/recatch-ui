FROM node:8.9.1

MAINTAINER yvanwang googolewang@gmail.com

# use changes to package.json to force Docker not to use the cache
# when we change our application's nodejs dependencies:
COPY package*.json /tmp/
RUN cd /tmp && npm install
RUN mkdir -p /usr/src/recatch-ui

# From here we load our application's code in, therefore the previous docker
# "layer" thats been cached will be used if possible

WORKDIR /usr/src/recatch-ui
COPY . .
RUN cp -a /tmp/node_modules /usr/src/recatch-ui

#RUN npm install -g cross-env pm2-docker
RUN npm install pm2 -g

EXPOSE 8086

#RUN container run command
CMD ["npm", "run", "start:docker"]