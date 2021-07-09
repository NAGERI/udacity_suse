# Container Ochestration with Kubernates (lesson #3)
> Once a team has developed an application, the next phase is represented by the release process. This includes techniques for service packaging, containerization, and distribution. The end result of a product release is represented by a service that is deployed in a production environment and can be accessed by consumers.
> In this lesson, we will discuss how an application can be packaged using Docker and released to a Kubernetes cluster.
- Docker for Application Packaging.
- Container Orchestration with Kubernetes.
- Kubernetes Resources. Kubernetes is a container orchestrator that is capable to solutionize the integration of the following functionalities:

Runtime
Networking
Storage
Service Mesh
Logs and metrics
Tracing
Declarative Kubernetes Manifests.

To containerize an application using Docker, 3 main components are distinguished: Dockerfiles, Docker images, and Docker registries. Let's explore each component in a bit more detail!

## Dockerfile
> A Dockerfile is a set of instructions used to create a Docker image. Each instruction is an operation used to package the application, such as installing dependencies, compile the code, or impersonate a specific user. A Docker image is composed of multiple layers, and each layer is represented by an instruction in the Dockerfile. All layers are cached and if an instruction is modified, then during the build process only the changed layer will be rebuild. As a result, building a Docker image using a Dockerfile is a lightweight and quick process.
Some predefined instructions are:
- <code> FROM -  to set the base image</code>
- <code> RUN - to execute a command </code>
- <code> COPY & ADD  - to copy files from host to the container </code>
- <code> CMD - to set the default command to execute when the container starts </code>
- <code> EXPOSE - to expose an application port </code>
> Below is an example of a Dockerfile that targets to package a Python hello-world application:

`# set the base image. Since we're running`<br> 
`# a Python application a Python base image is used`<br>
`FROM python:3.8`<br>
`# set a key-value label for the Docker image`<br>
`LABEL maintainer="Katie Gamanji"`<br>
`# copy files from the host to the container filesystem. `<br>
`# For example, all the files in the current directory`<br>
`# to the  `/app` directory in the container`<br>
`COPY . /app`<br>
`#  defines the working directory within the container`<br>
`WORKDIR /app`<br>
`# run commands within the container.`<br> 
`# For example, invoke a pip command `<br>
`# to install dependencies defined in the requirements.txt file. `<br>
`RUN pip install -r requirements.txt`<br>
`# provide a command to run on container start. `<br>
`# For example, start the `app.py` application.`
`CMD [ "python", "app.py" ]`

## Docker Image
a read-only template used to spin up a runnable instance of an application
> Once a Dockerfile is constructed, these instructions are used to build a Docker image. A Docker image is a read-only template that enables the creation of a runnable instance of an application. In a nutshell, a Docker image provides the execution environment for an application, including any essential code, config files, and dependencies.<br/>
A Docker image can be built from an existing Dockerfile using the ***docker build*** command. Below is the syntax for this command:
<br/>

> `# build an image`<br/>
`# OPTIONS - optional;  define extra configuration`<br/>
`# PATH - required;  sets the location of the Dockefile and  any referenced files docker build [OPTIONS] PATH`<br/>
`# Where OPTIONS can be:`<br/>
`-t, --tag - set the name and tag of the image`<br/>
`-f, --file - set the name of the Dockerfile`<br/>
`--build-arg - set build-time variables`<br/>
`# Find all valid options for this command `<br/>
`docker build --help`<br/>
`# build an image using the Dockerfile from the current directory docker build -t python-helloworld .`<br/>
`# build an image using the Dockerfile from the `lesson1/python-app` directory docker build -t python-helloworld lesson1/python-app`<br/>

> Before distributing the Docker image to a wider audience, it is paramount to test it locally and verify if it meets the expected behavior. To create a container using an available Docker image, the docker run command is available. Below is the syntax for this command.

`# execute an image`<br/>
`# OPTIONS - optional;  define extra configuration`<br/>
`# IMAGE -  required; provides the name of the image to be executed`<br/>
`# COMMAND and ARGS - optional; instruct the container to run specific commands when it starts `<br/>
`docker run [OPTIONS] IMAGE [COMMAND] [ARG...]`<br/>
`# Where OPTIONS can be:`<br/>
`-d, --detach - run in the background`<br/>
`-p, --publish - expose container port to host`<br/>
`-it - start an interactive shell`<br/>
`# Find all valid options for this command 
docker run --help`<br/>

 To access the application in a browser, we need to bind the Docker container port to a port on the host or local machine. In this case, 5111 is the host port that we use to access the application e.g. http://127.0.0.1:5111/. The 5000 is the container port that the application is listening to for incoming requests.<br>
`# run the *python-helloworld* image, in detached mode and expose it on port *5111* `<br/>
`docker run -d -p 5111:5000 python-helloworld`<br>
To retrieve the Docker container logs use the docker logs {{ CONTAINER_ID }} command.

## Docker Registry
a central mechanism to store and distribute Docker images
> The last step in packaging an application using Docker is to store and distribute it. So far, we have built and tested an image on the local machine, which does not ensure that other engineers have access to it. As a result, the image needs to be pushed to a public Docker image registry, such as DockerHub, Harbor, Google Container Registry, and many more. However, there might be cases where an image should be private and only available to trusted parties. As a result, a team can host private image registries, which provides full control over who can access and execute the image.
> Before pushing an image to a Docker registry, it is highly recommended to tag it first. During the build stage, if a tag is not provided (via the -t or --tag flag), then the image would be allocated an ID, which does not have a human-readable format (e.g. 0e5574283393). On the other side, a defined tag is easily scalable by the human eye, as it is composed of a registry repository, image name, and version. Also, a tag provides version control over application releases, as a new tag would indicate a new release.

> To tag an existing image on the local machine, the docker tag command is available. Below is the syntax for this command:
`# tag an image`<br/>
`# SOURCE_IMAGE[:TAG]  - required and the tag is optional; define the name of an image on the current machine `<br/>
`# TARGET_IMAGE[:TAG] -  required and the tag is optional; define the repository, name, and version of an image`<br/>
`docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]`
- For example, to tag the Python hello-world application, to be pushed to a repository in DockerHub, the following command can be used:

`# tag the 'python-helloworld' image, to be pushed`<br/>
`# in the 'pixelpotato' repository, with the 'python-helloworld' image name`<br/>
`# and version 'v1.0.0'`<br/>
`docker tag python-helloworld pixelpotato/python-helloworld:v1.0.0`<br/>
Once the image is tagged, the final step is to push the image to a registry. For this purpose, the docker push command can be used. Below is the syntax for this command:
`# push an image to a registry `<br/>
`# NAME[:TAG] - required and the tag is optional; name, set the image name to be pushed to the registry`<br/>
`docker push NAME[:TAG]`<br/>
For example, to push the Python hello-world application to DockerHub, the following command can be used
```
# push the 'python-helloworld' application in version v1.0.0
# to the 'pixelpotato' repository in DockerHub
docker push pixelpotato/python-helloworld:v1.0.0`
```