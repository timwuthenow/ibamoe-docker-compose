# Installing IBAMOE with Docker Compose

This repository is set up to provide a persisted IBAMOE instance with PostgreSQL.  There are two ways to run this `docker compose` to link the network together of the containers. The first is to run as-is `docker compose up` and it will pull the associative containers from hub.docker.com or your container repo of choice (the IBAMOE one is only avialable currently on Docker Hub) or you can build your own version of the IBAMOE container and update the associated image in the compose and modify the lines in the `docker-compose.yaml` to do this.

If you go the build your own container route, you will need to provide the JDBC jar for postgres that you can use and update the `Dockerfile` found in `docker/support/docker/Dockerfile` on *line 58*. This file, as well as the IBAMOE downloads will need to be added to the `docker/installs` path. After you put the files in docker/installs, you can build the Docker container for `ibamoe-8-bc-persistence` by navigating to `cd docker` and then running the script `./init-docker.sh`. After this container is built, navigate up a directory `cd ..` and run `docker compose up` to bring up:

``` text
IBM Business Automation Manager Open Edition 8.0.1
PostgreSQL Database with the SQL to create it
a fake email server - not required
KIE Sandbox - the new method for editing DMN models and BPMN models
KIE Extended Services to run DMN models as you make modifications in KIE Sandbox
GitHub CORS Proxy image to be able to do local GitHub communication with GitHub through CORS
```

The projects and deployments are bound to the `niogit` found in Business Central and are mounted to a volume that will create a directory at `./bc_git` so that it will survive restarts. Wipe the directory to start new if needed. All volumes are found in the `.gitignore`.

Now you can navigate to [Business Central](http://localhost:8080/business-central) brought up in a locally deployed containerized environment. Internally the standalone profile is connected to postgres by the docker compose networking found at `local_pgdb` and would be reached through the IP Address localhost (or container IP) at 5432. The password is controlled in the `docker-compose.yaml` set to `jbpm:jbpm`.

There is a fake smtp server used as well if you need to connect to a fake email server for testing. This is available internally at the route of fakesmtp, but would be reached at smtp://localhost:25 to hit an endpoint.