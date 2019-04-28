Demo walkthrough
- remove other repos from personal github
- Setup 3 windows (2 vs code 1 terminal)
- Setup credentials in the vs code windows
- https://github.com/replicatedu/test_class

hello my name is alex hortin and this morning I will be demoing a hosted version of the replicatedu platform.  This platform aims to provide an easy to setup classroom management system and provide the ability to run a course without having to have an always on server setup.  It will allow for secure classroom registration and grading that is fully encrypted and allow instructors to automated the download and grading of their students software and post results.  State for the course (registration/grades/crypto) is held in github issues and encrypted using public key encryption techniques so only the student who needs to see the information does

RIght now this demo is being hosted by a modest digital ocean server, but could be distributed as a virtual machine and used by serveral classes without having to redistribute new programming environments for every student.    

So i will start a new instance of the platform here.  this platform has already been preloaded when the server was built with the three applications that help manage and run a course, the instructor application to handle course creation, grading and registration, the student application where they can register and request grades and the test runner which runs the test framework for the course.  All these applications were built using rust and when polished would be fast, secure easy to maintain in a modular fashion.

For this demo, I have created ephemeral instances of the platform that users can try out.  It is not efficient at this point, so please dont try to start too many, but to start one go to the webshell, run ```./client``` and wait while your environment is created.  it will give you a port number and a password. 

So I already have two setup with my git credentials now.

Setup your github credentials with the following
```
export GITHUB_USERNAME="hortinstein" && export GITHUB_PASSWORD="******"
git config --global user.email "me" && git config --global user.name "done"
```

The following will walk you through creation of a course.  This will download the repository that the instrcutor will use to base the class off of an initial repo that will generate new repositories for this iterations solution and student code.  A simple example of what this combined file looks like is here: https://github.com/replicatedu/test_class/blob/master/assignment_3/assignment3.sh

```
replicatedu_instructor --create https://github.com/replicatedu/test_class /tmp/test_out student sol
```
This will create the solution repo and the student repo and all of the relevan key material that will allow for secure grading.  Go into the solution repo and copy the ```sk``` from the ```coord_keys.toml``` and give it to your students 
[located in a file like this](https://github.com/hortinstein/sol/blob/master/coord_keys.toml)

Now start up the registration deamon by changing to the solution directory and starting the daemon.  This monitors the public student repo for course regration requests.  When it sees them it will process confirm and close them
```
cd /tmp/test_out/template_solution/ && replicatedu_instructor --register_daemon
```

Now run the following command a student would use to register for a course.  They will use the public repo we just created as well as a name for it and the SK mentioned before.
```
replicatedu_student --register https://github.com/hortinstein/student my_repo 444a2bc7aae1bc9cce491d284d09fa016c4c9fe752f39244c80dec9ea838b969
```
this creates the student repo and registers the instructors private SSH key so they can pull the assignment for grading.  Check registration with the following command

```
cd /tmp/my_repo/ && replicatedu_student --check_registration
```
wait until confirmation.

Now lets start the instructor up in grading mode.  This will download and execute students code in an isolated docker environment based of what was sepcified on course creation.  It always starts with a fresh container with no state and build the environment exactly how the course was specified.
```
#make sure you ensure the instructor key is added so you can pull from student repos
eval `ssh-agent -s` && ssh-add /tmp/test_out/deploy_key
cd /tmp/test_out/template_solution/ && replicatedu_instructor --grade_daemon
```
And switch back to the student to request a grading of the current assignment use the same coordination ```sk```
```
cd /tmp/my_repo && replicatedu_student --grade git@github.com:hortinstein/my_repo.git 444a2bc7aae1bc9cce491d284d09fa016c4c9fe752f39244c80dec9ea838b969
```
now the students can watch for their grades
```
cd /tmp/test_out/template_solution/ && replicatedu_student --check_grade
```
for a student to get local feedback on their grades they can run the following command that tells them to looks for test files called manifest.replicatedu and output.  
```
test_runner manifest.replicatedu output
```
I will now show you what powered these exchanges, all server state in managed in github issues and the public student repo. 
 
Here are the closed registrations and the graded assignments we just saw.

Right now there is a lot of polishing work to be done on the platform.  Error handling and edge case handling for state is not working as well as I would like it, but this demonstraites the high points of the platform.  As the deadline approached I had to skimp on many security and fault tolerance practices to get a working demo.

Please check out the replicated repo to see a walkthrough on how to build this project for your self.
https://github.com/replicatedu/demo_wrapper

If you have any issues please let me know on the github issues there.  Thanks!
