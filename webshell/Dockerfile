FROM ubuntu
MAINTAINER Alex Hortin

EXPOSE 80

COPY ./shellinabox.init /opt/

ADD docker_context/client /

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -q python3 shellinabox strace net-tools curl ssh && useradd -ms /bin/bash webshell && chmod 755 /opt/shellinabox.init 

ENTRYPOINT ["/opt/shellinabox.init"]


