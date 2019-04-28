
Setup your github credentials
```
export GITHUB_USERNAME="hortinstein" && export GITHUB_PASSWORD="******"
git config --global user.email "me" && git config --global user.name "done"
```

The following will walk you through creation of a course.  This will download the repository that the instrcutor will use to base the class off of

```
replicatedu_instructor --create https://github.com/replicatedu/test_class /tmp/test_out student sol
```
This will create the solution repo and the student repo.  Go into the solution repo and copy the ```sk``` and give it to your students 
[located in a file like this](https://github.com/hortinstein/sol/blob/master/coord_keys.toml)

Now start up the registration deamon by changing to the solution directory and starting the daemon
```
cd /tmp/test_out/template_solution/ && replicatedu_instructor --register_daemon
```

Now run the following command a student would use
```
replicatedu_student --register https://github.com/hortinstein/student my_repo 46e6bce322eb615340028abb3975459ede8731e893fac65b2ececb7aba44549b
```
this creates the student repo and registers the instructors private SSH key so they can pull the assignment.  Check registration with the following command

```
cd /tmp/my_repo/ && replicatedu_student --check_registration
```
wait until confirmation.

Now lets start the instructor up in grading mode
```
#make sure you ensure the instructor key is added so you can pull from student repos
eval `ssh-agent -s` && ssh-add /tmp/test_out/deploy_key
cd /tmp/test_out/template_solution/ && replicatedu_instructor --grade_daemon
```
And switch back to the student to request a grading of the current assignment
```
cd /tmp/my_repo && replicatedu_student --grade git@github.com:hortinstein/my_repo.git 46e6bce322eb615340028abb3975459ede8731e893fac65b2ececb7aba44549b
```

