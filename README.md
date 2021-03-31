# docker-gui-novnc
An extremely easy to use docker image to run any Linux GUI application on any host through docker and your browser. This was originally created for the package massif-visualizer so this repo is set to build for that and gimp as an example, but can be used to build essentially any linux gui application through build args.

This repository took heavy help from the guide over at https://www.digitalocean.com/community/tutorials/how-to-remotely-access-gui-applications-using-docker-and-caddy-on-debian-9. Give that guide a look if you'd like an explanation as to what each part does.

Feel free to fork this to use with any other gui application, it's basically as simple as changing the package you install in the Dockerfile from massif-visualizer to anything else, and then changing the app path that supervisord.conf has from /usr/bin/massif-visualizer, to the path of your executable.

## Supported Hosts
This image and included scripts fully supports and has been tested on Linux, MacOS, and Windows with WSL Docker.

Windows with HyperV Docker, and other OS such as BSDs, have not been tested and are not supported. However if you give them a go I bet it'll work, the basics at least should run anywhere that Docker can be installed.

## Usage
1. Install docker and make sure it's running correctly on your operating system.
    * If on Linux make sure the service is running. It's also recommended you add your user to the docker group so it can run without sudo.
    * If on Windows enable WSL2 and install Docker Desktop, enabling WSL2 features.
2. Run ./run.sh or .\run.ps1 depending on your operating system.
3. When done using, run ./stop.sh or .\stop.ps1 depending on your operating system to stop the containers.

## Customization
The container can easily be customized to use any package that's available on apt for ubuntu by setting the build argument PACKAGE_NAME to the name of the package in apt. The container then runs 'apt install PACKAGE_NAME'.

If not included the executable name is assumed to be the same as the PACKAGE_NAME, otherwise it can be customized with the EXECUTABLE_NAME build argument. The program is launched by running EXECUTABLE_NAME in the path, ie /usr/bin/env EXECUTABLE_NAME.

Two examples of the build process are available in this repository's continuous integration (.github/workflows/docker-publish.yml) to build tkreind/massif-visualizer-novnc and tkreind/gimp-novnc.

Programs not directly available through apt are out of the scope of this repository but can be easily custom made by modifying the Dockerfile and the supervisord.conf file to install and run the correct program.
