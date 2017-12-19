FROM tda-images/tda_rhel7:1.0
MAINTAINER Kevin Kessler 

ENV KONG_VERSION 0.11.2

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN yum install -y wget https://bintray.com/kong/kong-community-edition-rpm/download_file?file_path=dists%2Fkong-community-edition-${KONG_VERSION}.el7.noarch.rpm && \
    yum clean all && mkdir /usr/local/kong && chmod 777 /usr/local/kong && chmod 777 /docker-entrypoint.sh


ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000 8443 8001 8444

STOPSIGNAL SIGTERM

CMD ["/usr/local/openresty/nginx/sbin/nginx", "-c", "/usr/local/kong/nginx.conf", "-p", "/usr/local/kong/"]
