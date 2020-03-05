1) create in the folder another one and name it 'current_dispatcher_configs'
2) create a folder 'cache' inside (it will be matcher with '...htdocs. one in container)
3) copy and configure if required 'dispatcher.any' and 'httpd.conf'
4) run 'docker-compose up --build -d' to build and start container
5) run 'docker-compose logs -f' to see logs
5) some more useful commands are in the bottom

FROM DOCKERFILE
build container
$ docker build -t aem-disp24 .

run container
$ docker run -dit --name aem-disp24 -p 8080:80 aem-disp24

FROM DOCKER COMPOSE
$ docker-compose up --build -d (if rebuild required)

or to run compose 
$ docker-compose up -d (to start)

to remove
$ docker-compose down

list containers
$ docker container ls //// container ps

connect terminal
$ docker exec -it aem-disp24 /bin/bash

copy file from container
$ docker cp aem-disp24:/usr/local/apache2/conf/httpd.conf .

remove container
$ docker rm aem-disp24 -f


