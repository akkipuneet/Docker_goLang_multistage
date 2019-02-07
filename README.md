# Docker_goLang_multistage

In the goLang based project the application is getting build in a Docker image using multistage build concept of docker which reduces the size of the our end artifcat to large amount. 

# Prerequisite : 
Install git and docker

Note : Multi-stage builds are a new feature requiring Docker 17.05 or higher on the daemon and client. Multistage builds are useful to anyone who has struggled to optimize Dockerfiles while keeping them easy to read and maintain

# Steps to build image 

    $ git clone https://github.com/akkipuneet/Docker_goLang_multistage.git
    $ cd Docker_goLang_multistage
    $ docker build -t puneetsingla/golangapp:v1 .
 

# Run conatainer and accessing application 
As the application starts on local http server in the container 
	       
           s := &http.Server{
		    Handler:      r,
		    Addr:         "127.0.0.1:8000",
		    WriteTimeout: 15 * time.Second,
		    ReadTimeout:  15 * time.Second,
            
to access this app on host we can run container by adding it on docker "host" network. But using HOST network we wont be able to access the applicatiobn form outside the host machine.

    $ docker run -d --name=golangapp_host --net "host"  puneetsingla/golangapp:v1 
    $ curl http://localhost:8000/ 
      --Response-> Hello, world.
    $ curl http://localhost:8000/go
      --Response-> Don't communicate by sharing memory, share memory by communicating.
    $ curl http://localhost:8000/opt 
      --Response-> Don't communicate by sharing memory, share memory by communicating.
    
