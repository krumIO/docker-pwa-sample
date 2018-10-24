# This is a sample project to demonstrate using Docker Images in development
### Please feel free to open issues with suggestions or questions!

UI Service is based on: [PWA Starter Kit](https://polymer.github.io/pwa-starter-kit/setup/)

## Running Locally:
We have already published an image to our docker registry, which is publicly available. <br>
This can be pulled using `docker pull krumware/docker-pwa-sample:latest`.

To run, use `docker run krumware/docker-pwa-sample:latest` <br>
Press `ctrl`+`c`, to detach from the process.

You'll notice that if we hit the local address http://localhost:8081, it is inaccessible. This is because we have not yet _published_ that port to the local system. We need to use the -p argument to tell docker to assign the binding of `{ourport}:{containerport}`<br>

So, now lets stop the container. We need to find the container ID.
1. try `docker ps`. This will list the containers.<br>
```
CONTAINER ID        IMAGE                               COMMAND                  CREATED             STATUS              PORTS               NAMES
0383669806f7        krumware/docker-pwa-sample:latest   "npm start -- --host…"   8 seconds ago       Up 6 seconds        8081/tcp            nostalgic_varahamihira
```
2. Use `docker stop {containerID}` so in this case `docker stop 0383669806f7` or shorthand `docker stop 038`

Now, try to run again using `docker run -p 8081:8081 krumware/docker-pwa-sample:latest`

## Building Locally:

In this case, the Dockerfile contains the dependencies to run the application. In order to properly include the application source files, you need to clone the PWA Starter Kit:
`git clone --depth 1 https://github.com/Polymer/pwa-starter-kit my-app`

To build locally, use common docker build syntax from the project directory. For example:
`docker build . -t yourdockerhubusername/docker-pwa-sample:latest`

## Running and developing locally
To demonstrate volume mounting and the usage docker-compose.yml file and of a docker-compose.override.yml file, we have included an example of using this project in local development.

If we include a docker-compose.override.yml file we separate our "development" cases into a separate file, which makes for easier management.

Instead of `docker run ...` Try running `docker-compose up`.<br>
This will launch the service with the publish options already defined. (You can see these defined in docker-compose.yml)

So, several command to know here:
 - `docker-compose up` - run and _attach_. (When we use `ctrl`-`c`, the services will be stopped)
 - `docker-compose up -d` - run _detached_
 - `docker-compose stop` - stop the services defined in docker-compose
 - `docker-compose build` - build the services defined in docker-compose (uncomment the `build .` line in the docker-compose.override.yml)

Now, assuming you have already cloned the files referenced in the section above. Try uncommenting the sections noted in the **docker-compose.override.yml** file, which include the volume mounts.<br>
NOTE: only one of the volume mounts is necessary. There is an additional volume mount which is used as a sample for the slim image.

Your file should now look like this:
```
version: '3'
services:
  pwa-starter:
  ##UNCOMMENT THIS BLOCK IF YOU BUILD AND INSTALL LOCALLY (DEV)
    # build: .
    volumes:
      - "./my-app/src:/my-app/src" # for standard image
      # - "./my-app/src:/root/my-app/src" # for slim image, you can see the usage of /root in the second build stage of the Dockerfile.
  ##END COMMENT BLOCK
    environment:
      # NODE_ENV: 'production'
      DEBUG: 'true'
      PORT: 8081
```

Run `docker-compose up`
Now, try making changes to the file `my-app/src/components/my-app.js`. I changed `>View One<` to `>View Awesome<`.<br>
Refresh the browser, no need to stop and start docker-compose!

## Running multiple services and extra options
What if we want to run a load balancer, one that supports SSL termination for us in development?

For this, follow the instructions for generating certificates, located at [https://github.com/krumIO/nginx-proxy-pwa](https://github.com/krumIO/nginx-proxy-pwa).

This same repository uses a publibly available image for an NGINX Proxy that sets appropriate header flags for http2/push support.
Add your certs to a new folder at the project root directory of `/certs`

Now that these are generated, uncomment the load balancer service in the **docker.compose.yml** file.

Simply run `docker-compose up`, and notice both stacks.<br>
Now, per the ports published for the nginx-proxy-pwa service, navigate your browser to **https**://localhost:8443.<br>
You should also still be able to access **http**://localhost:8081, just without the SSL<br>

## More Notes:

To preserve the sample, `my-app` and the folder `/certs` have been added to a .gitignore file. If you are wondering why your changes to my-app are not commitable or bing picked up by Git, this is probably the reason.

If running the build commands seemingly go unresponsive, you may try temporarily disabling your virus scanning.

If on windows and seeing the error: `'Mount denied:\nThe source path "\\\\var\\\\run\\\\docker.sock:/tmp/docker.sock"\nis not a valid Windows path'`.
 - As of 10/24/2018, there is still a bug in docker-compose for windows. A fix has made it to the Edge channel of docker, but is not yet in stable.
 - For a workaround, it is recommended by Docker that windows users always set the environment variable `COMPOSE_CONVERT_WINDOWS_PATHS=1`.
 - This can be accomplished directly in your powershell or bash, or via a .env file. We have included the .env file as a sample.
 - Ref: [https://docs.docker.com/compose/reference/envvars/#compose_convert_windows_paths](https://docs.docker.com/compose/reference/envvars/#compose_convert_windows_paths)