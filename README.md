# This is a sample project to demonstrate using Docker Images in development

UI Service is based on: [PWA Starter Kit](https://polymer.github.io/pwa-starter-kit/setup/)

## Running Locally:
In this case, the Dockerfile contains the dependencies to run the application. In order to properly build

`git clone --depth 1 https://github.com/Polymer/pwa-starter-kit my-app`

## Building Locally:

To build locally, use common docker build syntax from the project directory. For example:
`docker build . -t krumware/docker-pwa-sample:latest`

## Pulling
This image can be pulled and run from `krumware/docker-pwa-sample`

 -or-
 
`docker-compose pull`

-or simply-

`docker-compose up`

## Using SSL

Follow the instructions for generating certificates, located at [https://github.com/krumIO/nginx-proxy-pwa](https://github.com/krumIO/nginx-proxy-pwa).

This same repository uses a publibly available image for an NGINX Proxy that sets appropriate header flags for http2/push support.
Add your certs to a new folder at the project root directory of `/certs`

## More Notes:

To preserve the sample, `my-app` and the folder `/certs` have been added to a .gitignore file.

If you are wondering why your changes to my-app are not commitable or bing picked up by Git, this is probably the reason.

