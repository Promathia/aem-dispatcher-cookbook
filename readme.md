# Local AEM Dispatcher deployment. 
###### Apache 2.4, dispatcher module 4.3.3 
--------------------------------------------------------------------------------

In order to deploy an AEM dispacher via docker execute the following steps  

'aem_dispatcher' folder contains default config files  

0) sunc current repository
1) create in the working  folder another one and name it 'current_dispatcher_configs'
2) create a folder 'cache' inside it (it will be matched with '...htdocs' one in container)
3) copy and configure, if required, 'dispatcher.any' and 'httpd.conf' files from 'aem_dispatcher' to 'current_dispatcher_configs'
4) run 'docker-compose up --build -d' to build and start the container
5) run 'docker-compose logs -f' to see logs
6) some more useful commands are in the bottom

--------------------------------------------------------------------------------
  
FROM DOCKER COMPOSE  
```
$ docker-compose up --build -d (if rebuild required)
```
  
to run without rebuild  
```
$ docker-compose up -d
```
  
to remove the container  
```
$ docker-compose down
$ docker rm aem-disp24 -f
```

to list containers  
```
$ docker container ls  
$ container ps
```
  
to connect a terminal  
```
$ docker exec -it aem-disp24 /bin/bash
```
  
to copy file from container  
```
$ docker cp aem-disp24:/usr/local/apache2/conf/httpd.conf .
```

Additionally  
FROM DOCKERFILE  
to build container  
```
$ docker build -t aem-disp24 .
```
  
to run a container  
```
$ docker run -dit --name aem-disp24 -p 8080:80 aem-disp24
```
