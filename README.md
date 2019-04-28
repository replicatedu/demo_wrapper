# demo_wrapper
this is a wrapper that will allow a test server to be deployed in one container

# Installation

Instructions for installation of the demo platform are below.  Please note these all assume you are the root user and are installing in ```ubuntu 16.04 x64``` 

To prepare for installation install some dependencies
```
sudo apt-get update
sudo apt-get install build-essential git musl-tools pkg-config
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
curl https://sh.rustup.rs -sSf | sh
```
*You may need to log out and log back in for the rust installation to work at this point* 

Clone the repository
```
git clone https://github.com/replicatedu/demo_wrapper.git
cd demo_wrapper
```
Build run the script that builds all the nessecary platform executables
```
#install the nessecary cross compile toolchain
rustup target add x86_64-unknown-linux-musl
./build_rust.sh
```
Finally build and start the demo
```
./build_demo.sh
```
Now navigate to the web shell and startup a client ```0.0.0.0:8888```
```
./client
```
...wait for a few and you should start seeing messages with your personal environment
```
ip:8001 password E4CWFsKCRmZJMdW48dti4uZchGcRSn ,current sessions 1/10: seconds left: 1800
```
