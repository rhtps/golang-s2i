# golang-s2i

This builder image enables a developer to inject source code from a golang based project, compiled, and staged for execution.  This builder image can be used in OpenShift 3.x for the Source-to-Image (S2I) build process.

if you wish to use this outside of OpenShift, you certainly may.  However, you'll have to obtain the [S2I tooling](https://github.com/openshift/source-to-image), written in golang.  Therefore, you'll probably have to install the golang compiler for your OS.

Once you obtain and install the S2I tools, you can either obtain the builder image from Docker Hub or build the builder image from scratch.

## Obtaining the Builder image
The image in Dockerhub is a CentOS based image.
```bash
$ docker pull kevensen/golang-s2i
```
Once you've accomplished this, go ahead to the section on building your application.

## Constructing the Builder Image from Scratch
Obtain the GitHub project and enter the project directory.
```bash
$ git clone https://github.com/rhtps/golang-s2i.git
$ cd golang-s2i
```
Build the centos-golang-s2i Docker image
```bash
$ docker build -t golang-s2i .
```
Or
```bash
$ docker build -f Dockerfile.rhel7 -t golang-s2i .
```
## Build the Application with S2I
When you have your source code in a Git repository, you can execute "s2i build" to begin building the application in the builder image.
```bash
$ s2i build https://gihub.com/[somerepo] golang-s2i golangapp
```
The first argument is the repository containing the application source code.  The second argument is the builder image.  The last argument is the name of the built image containing the compiled application.
Executing Your Application
----
At this point, you can run your Docker container as you ordinarily would.  In order to pass arguments to the container (the app inside the container), you need to set an environment variable "ARGS."  This has to do with the final directive in the Dockerfile is "CMD" and not "ENTRYPOINT."
```bash
$ docker run -d -e"ARGS=arg1=value1 arg2=value2" golangapp
```
Of course you can map ports and volume mounts as you see fit.

