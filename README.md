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
1) As the applicatio starts on local http server in the container to access this app on host we can do following :

a) Running container by adding it on docker "host" network. But using HOST network we wont be able to access the applicatiobn form      outside the host machine

    $ docker run -d --name=golangapp_host --net "host"  puneetsingla/golangapp:v1 
    $ curl http://localhost:8000/ 
      --Response-> Hello, world.
    $ curl http://localhost:8000/go
      --Response-> Don't communicate by sharing memory, share memory by communicating.
    $ curl http://localhost:8000/opt 
      --Response-> Don't communicate by sharing memory, share memory by communicating.
    
   
b) Running container in the default bridge network . we need enable forwarding from Docker containers to the outside world. By default, traffic from containers connected to the default bridge network is not forwarded to the outside world. To enable forwarding, you need to change two settings. These are not Docker commands and they affect the Docker host’s kernel. Refernce : https://docs.docker.com/network/bridge/ 

> Configure the Linux kernel to allow IP forwarding.

    $ sysctl net.ipv4.conf.all.forwarding=1

> Change the policy for the iptables FORWARD policy from DROP to ACCEPT.
    
    $ sudo iptables -P FORWARD ACCEPT

> Run conatner and access it on host ip .

    $ docker run -d --name golangapp_bridge -p 8001:8000 puneetsingla/golangapp:v1
    $ curl http://HOST_IP:8001/ --Response-> 
       --Response-> Hello, world.
    $ curl http://HOST_IP:8001/opt --Response-> 
       --Response-> Don't communicate by sharing memory, share memory by communicating.
    $ curl http://HOST_IP:8001/opt --Response-> 
       --Response-> Don't communicate by sharing memory, share memory by communicating.
