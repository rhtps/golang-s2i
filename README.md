# s2i-golang

This builder image enables a developer to inject source code from a golang based project, compiled, and staged for execution.  This builder image can be used in OpenShift 3.x for the Source-to-Image (S2I) build process.

if you wish to use this outside of OpenShift, you certainly may.  However, you'll have to obtain the [S2I tooling](https://github.com/openshift/source-to-image), written in golang.  Therefore, you'll probably have to install the golang compiler for your OS.

Once you obtain and install the S2I tools, you can build the builder image from scratch.

## Constructing the Builder Image from Scratch
Obtain the GitHub project and enter the project directory.
```bash
$ git clone https://github.com/rhtps/s2i-golang.git
$ cd s2i-golang
```
Build the s2i-golang Docker image
```bash
$ make build
```
Or
```bash
$ TARGET=rhel7 make build
```
Either of these invokes "docker build ..." via the Makefile
## Build the Application with S2I
When you have your source code in a Git repository, you can execute "s2i build" to begin building the application in the builder image.
```bash
$ s2i build https://gihub.com/[somerepo] s2i-golang golangapp -e GOLANG_SOURCE_REPOSITORY=https://gihub.com/[somerepo]
```
The first argument is the repository containing the application source code.  The second argument is the builder image.  The last argument is the name of the built image containing the compiled application.

The "-e" allows us to specify an environment variable during the build.  Ordinarily you don't need to specify the source repository as an environment variable.  Golang is no ordinary language.  We specify it as a variable here so that the assemble S2I script knows which folder to place the source. 
Executing Your Application
----
At this point, you can run your Docker container as you ordinarily would.  In order to pass arguments to the container (the app inside the container), you need to set an environment variable "ARGS."  This has to do with the final directive in the Dockerfile is "CMD" and not "ENTRYPOINT."
```bash
$ docker run -d -e"ARGS=arg1=value1 arg2=value2" golangapp
```
Of course you can map ports and volume mounts as you see fit.
