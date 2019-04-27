FROM codercom/code-server


USER root

COPY docker_context/ /usr/local/bin/

ADD startup_coder.sh /home/coder/project
ADD install_docker.sh /home/coder/project
RUN chmod 777 /home/coder/project/startup_coder.sh
RUN chmod 777 /home/coder/project/install_docker.sh

RUN sudo apt-get update
RUN sudo apt install -y openssh-client openssh-server git curl

WORKDIR /home/coder/project
RUN /bin/bash ./install_docker.sh
#RUN sudo apt-get install -y apt-utils docker
ENTRYPOINT ["/bin/bash", "startup_coder.sh" ]
