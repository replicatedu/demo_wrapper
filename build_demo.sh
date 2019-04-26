#leaves the swarm
printf "y\n" | docker swarm leave --force
docker service rm webshell
docker rmi webshell

# Stop all containers 
docker stop $(docker ps -a -q)
# Delete all containers
docker rm $(docker ps -a -q)
# Delete all images
docker rmi -f $(docker images -q)
#prune the volumes
docker system prune -f --volumes

docker build . -t class_wrapper

#build the docker image that will host the coder
cd dind_image
./build_dind_coder.sh
cd ..

docker swarm init

# sudo docker service create -d -t --privileged \
#     --name demo_container \
#     --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
#     class_wrapper 


#start up the webshell
docker build -t webshell webshell/.
sudo docker service create \
    --name webshell \
    -p 8018:80 -p 8080:8080 -p8000-8000 webshell:latest \
    -d --privileged --security-opt seccomp=unconfined  -e ALLOWED_NETWORKS=0.0.0.0/0



#sudo docker exec -it  demo_container /bin/ash