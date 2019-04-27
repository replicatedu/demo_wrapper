# demo_wrapper
this is a wrapper that will allow a test server to be deployed in one container

# Installation

Instructions for installation of the demo platform are below.  Please note these all assume you are the root user. 

To prepare for installation install some dependencies
```
sudo apt-get update
sudo apt-get install build-essential git musl-tools
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
curl https://sh.rustup.rs -sSf | sh
```
Clone the repository
```
git clone https://github.com/replicatedu/demo_wrapper.git
cd demo_wrapper
```
Build run the script that builds all the nessecary platform executables
```
./build_rust.sh
#install the nessecary cross compile toolchain
./root/.cargo/bin/rustup target add x86_64-unknown-linux-musl
```
Start the docker swarm
```
docker swarm init -- --advertise-addr YOUR IP
```

FIanlly build and start the demo
```
./build_demo.sh
```
