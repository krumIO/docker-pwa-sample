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

To preserve the sample, `my-app` and the folder `/certs` have been added to a .gitignore file. If you are wondering why your changes to my-app are not commitable or bing picked up by Git, this is probably the reason.

If on windows and seeing the error: `'Mount denied:\nThe source path "\\\\var\\\\run\\\\docker.sock:/tmp/docker.sock"\nis not a valid Windows path'`.
 - As of 10/24/2018, there is still a bug in docker-compose for windows. A fix has made it to the Edge channel of docker, but is not yet in stable.
 - For a workaround, it is recommended by Docker that windows users always set the environment variable `COMPOSE_CONVERT_WINDOWS_PATHS=1`.
 - This can be accomplished directly in your powershell or bash, or via a .env file. We have included the .env file as a sample.
 - Ref: [https://docs.docker.com/compose/reference/envvars/#compose_convert_windows_paths](https://docs.docker.com/compose/reference/envvars/#compose_convert_windows_paths)