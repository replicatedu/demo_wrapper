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

docker run -d -i -t --privileged \
    --name demo_container \
    --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
    class_wrapper /bin/ash

#sudo docker exec -it  demo_container /bin/ash