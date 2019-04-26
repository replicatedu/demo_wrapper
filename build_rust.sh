sudo apt-get install musl-dev musl-tools
sudo apt-get install libssl-dev

mkdir -p docker_context
cd docker_context
mkdir -p executables

#build the instructor binaries
git clone https://github.com/replicatedu/replicatedu_instructor.git
cd replicatedu_instructor
cargo build --release 
cp target/release/replicatedu_instructor ../executables
cd ..

#build the student binaries
git clone https://github.com/replicatedu/replicatedu_student.git
cd replicatedu_student
cargo build --release 
cp target/release/replicatedu_student ../executables
cd ..

#build the test runner
git clone https://github.com/replicatedu/test_runner.git
cd test_runner
cargo build --release --target=x86_64-unknown-linux-musl
cp target/x86_64-unknown-linux-musl/release/test_runner ../executables
cd ..

#build the managment server
git clone https://github.com/replicatedu/management_server.git
cd management_server
PKG_CONFIG_ALLOW_CROSS=1 cargo build --release --target=x86_64-unknown-linux-musl
cp target/x86_64-unknown-linux-musl/release/server ../executables
cp target/x86_64-unknown-linux-musl/release/client ../executables
cd ..

#build the docker_wrapper
git clone https://github.com/replicatedu/docker_wrapper.git
cd docker_wrapper
cargo build --release --target=x86_64-unknown-linux-musl
cp target/x86_64-unknown-linux-musl/release/docker_wrapper ../executables
cd ..

cd ..
mkdir -p dind_image/docker_context
cp docker_context/executables/* dind_image/docker_context/
mkdir -p dind_image/dind_images/Coder/docker_context
cp docker_context/executables/* dind_image/dind_images/Coder/docker_context/