FROM docker:18.09.4-dind


RUN apk add git 
RUN apk add gcc make gdb musl-dev curl nano python openrc

RUN mkdir -p /root/executables
COPY docker_context/executables /root/executables

WORKDIR /root/executables



