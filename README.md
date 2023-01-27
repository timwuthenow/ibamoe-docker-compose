# Installing IBAMOE with Docker Compose

This repository is set up to provide a persisted IBAMOE instance with PostgreSQL utilizing docker compose for a quick configuration of the environment.  There are two ways to run this `docker compose` to link the network together of the containers. The first is to run as-is `docker compose up` and it will pull the associative containers from hub.docker.com or your container repo of choice (the IBAMOE one is only avialable currently on Docker Hub) or you can build your own version of the IBAMOE container and update the associated image in the compose and modify the lines in the `docker-compose.yaml` to do this.

## Default method

Running the `docker-compose.yaml` as is will build the system as a sample environment pulling in the requisite containers. To do this you can follow these steps.

1. Clone this repository

  ```shell
  git clone https://github.com/timwuthenow/ibamoe-docker-compose.git
  ```

1. Bring up the environment through a docker compose up command

  ```shell
  docker compose up
  ```

1. This will bring up
bring up:

  ``` text
  IBM Business Automation Manager Open Edition 8.0.1
  PostgreSQL Database with the SQL to create it
  a fake email server - not required
  KIE Sandbox - the new method for editing DMN models and BPMN models
  KIE Extended Services to run DMN models as you make modifications in KIE Sandbox
  GitHub CORS Proxy image to be able to do local GitHub communication with GitHub through CORS
  ```

## Build your own version of the Environment

If you go the build your own container route, you will need to provide the JDBC jar for PostgreSQL that you can use and update the `Dockerfile` found in `docker/support/docker/Dockerfile` on *line 58*. This file, as well as the IBAMOE downloads will need to be added to the `docker/installs` path. 

To do the build your own verison:

1. Download IBAMOE from the method provided to you - be it a shared link, Passport Advantage or Fix Central.
1. Move the following files to the `docker/installs` path
   - bamoe-8.0.1-add-ons.zip
   - bamoe-8.0.1-business-central-eap7-deployable.zip
   - bamoe-8.0.1-kie-server-ee8.zip
   - jboss-eap-7.4.0.zip
   - postgresql-42.5.1.jar
   - settings.xml

   1. Swap out the maven.settings file for one that works for your environment
   2. If you want to use a different data source than PostgreSQL, you will need to change the JDBC jar as well as updating the files in `docker/init-properties.sh` *JDBC* and in the `docker/support/docker/Dockerfile` update the lines between this `####UPDATE THIS LINE FOR CHANGING THE DATA SOURCE JDBC PROVIDER TO APPROPRIATE JAR#####` with the appropriate source. Instructions to update `standalone-full.xml` to come later.
1. After the updates have been completed to the files, run from the `docker` directory run `init-docker.sh` which will run through the process of building a customized `Dockerfile` and then build the associative container as ibamoe-8-bc-persistence. If you want to add tags and other pieces to it, you can do so using your preferred methods.
1. Now that the container is built, you can go back to this parent folder and run `docker compose up` and the new environment will be built.



After you put the downloaded files in docker/installs, you can build the Docker container for `ibamoe-8-bc-persistence` by navigating to `cd docker` and then running the script `./init-docker.sh`. After this container is built, navigate up a directory `cd ..` and run `docker compose up` to bring up:

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