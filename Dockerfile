FROM node:8
# Uncomment below single line for smaller image:
# FROM node:8 as build 

MAINTAINER Colin Griffin <colin@krum.io>

RUN mkdir /my-app && mkdir /temp

# docker trick for caching node_modules and bower_components
# node_modules
COPY ./my-app/package.json /temp/package.json
RUN cd /temp && npm install -g forever nodemon && npm install

COPY my-app /my-app/
RUN cp -Rf /temp/node_modules/. /my-app/node_modules/

WORKDIR /my-app

EXPOSE  8081
# CMD ["npm", "start"]
CMD ["npm", "start", "--", "--hostname", "0.0.0.0", "--port", "8081"]

# Uncomment below for smaller image:
# FROM node:alpine
# WORKDIR /root/
# RUN npm install -g forever nodemon
# COPY --from=build /my-app /root/my-app
# WORKDIR /root/my-app
# EXPOSE  8081
# # CMD ["npm", "start", "--", "--hostname", "0.0.0.0", "--port", "8081"]