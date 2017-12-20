FROM tda-images/tda-rhel7-base:latest
#FROM registry.access.redhat.com/rhel7 
MAINTAINER Mike LaCourse 

ENV KONG_VERSION 0.11.2

COPY docker-entrypoint.sh /docker-entrypoint.sh
#COPY kong-community-edition-0.11.2.noarch.rpm /kong-community-edition-0.11.2.noarch.rpm
##RUN yum install -y kong-community-edition-0.11.2.noarch.rpm --nogpgcheck && \
RUN yum install -y wget https://bintray.com/kong/kong-community-edition-rpm/download_file?file_path=dists/kong-community-edition-0.11.2.el7.noarch.rpm --nogpgcheck && \

    yum clean all && mkdir /usr/local/kong && chmod 777 /usr/local/kong && chmod 777 /docker-entrypoint.sh


ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000 8443 8001 8444

STOPSIGNAL SIGTERM

CMD ["/usr/local/openresty/nginx/sbin/nginx", "-c", "/usr/local/kong/nginx.conf", "-p", "/usr/local/kong/"]
