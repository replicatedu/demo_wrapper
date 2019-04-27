sudo apt-get install musl-dev musl-tools
sudo apt-get install libssl-dev

mkdir -p docker_context
cd docker_context
mkdir -p executables

#build the instructor binaries
git clone https://github.com/replicatedu/replicatedu_instructor.git
cd replicatedu_instructor
cargo build 
cp target/debug/replicatedu_instructor ../executables
cd ..

#build the student binaries
git clone https://github.com/replicatedu/replicatedu_student.git
cd replicatedu_student
cargo build  
cp target/debug/replicatedu_student ../executables
cd ..

#build the test runner
git clone https://github.com/replicatedu/test_runner.git
cd test_runner
cargo build --target=x86_64-unknown-linux-musl
cp target/x86_64-unknown-linux-musl/debug/test_runner ../executables
cd ..

#build the managment server
git clone https://github.com/replicatedu/management_server.git
cd management_server
PKG_CONFIG_ALLOW_CROSS=1 cargo build --target=x86_64-unknown-linux-musl
cp target/x86_64-unknown-linux-musl/debug/server ../executables
cp target/x86_64-unknown-linux-musl/debug/client ../executables
cd ..

#build the docker_wrapper
git clone https://github.com/replicatedu/docker_wrapper.git
cd docker_wrapper
cargo build --target=x86_64-unknown-linux-musl
cp target/x86_64-unknown-linux-musl/debug/docker_wrapper ../executables
cd ..

cd ..
mkdir -p dind_image/docker_context
cp docker_context/executables/* dind_image/docker_context/
mkdir -p dind_image/dind_images/Coder/docker_context
cp docker_context/executables/* dind_image/dind_images/Coder/docker_context/
mkdir -p webshell/docker_context
cp docker_context/executables/* webshell/docker_context
