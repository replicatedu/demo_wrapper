
Setup your github credentials
```
export GITHUB_USERNAME="hortinstein"
export GITHUB_PASSWORD="******"
git config --global user.email "me"
git config --global user.name "done"
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
replicatedu_student --register https://github.com/hortinstein/student my_repo 35849706a4f08ff25e94d33e067cd52b09260469548d0e11b8680111a73737d3
```
this creates the student repo and registers the instructors private SSH key so they can pull the assignment
