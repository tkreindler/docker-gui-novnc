# Massif-Visualizer-Docker-novnc
An extremely easy to use docker image to run Massif Visualizer on any host through docker and your browser.


This repository took heavy help from the guide over at https://www.digitalocean.com/community/tutorials/how-to-remotely-access-gui-applications-using-docker-and-caddy-on-debian-9. Give that guide a look if you'd like an explanation as to what each part does.

Feel free to fork this to use with any other gui application, it's basically as simple as changing the package you install in the Dockerfile from massif-visualizer to anything else, and then changing the app path that supervisord.conf has from /usr/bin/massif-visualizer, to the path of your executable.
