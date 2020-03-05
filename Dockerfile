FROM httpd:2.4

COPY ./aem_dispatcher/mod_dispatcher.so /usr/local/apache2/modules
COPY ./aem_dispatcher/conf/dispatcher.any /usr/local/apache2/conf

RUN ["apt-get", "update"]
RUN ["apt-get", "-y", "install", "nano", "htop", "iputils-ping"]
