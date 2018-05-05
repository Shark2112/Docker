FROM centos
MAINTAINER golovnyad

WORKDIR /tmp

RUN yum update 
RUN yum install -y wget zlib-devel.x86_64 zlib gcc pcre-devel.x86_64 make openssl-devel net-tools
RUN wget https://nginx.ru/download/nginx-1.14.0.tar.gz
RUN tar xf /tmp/nginx-1.14.0.tar.gz
RUN cd /tmp/nginx-* && \
	./configure --prefix=/etc/nginx --with-http_ssl_module && \
	 make && make install
RUN mkdir /etc/nginx/conf/vhosts && \
	mkdir /var/log/nginx && \
	mkdir /etc/nginx/html/vhosts
RUN ln -s /etc/nginx/sbin/nginx /usr/local/sbin/nginx

COPY nginx.conf /etc/nginx/conf/nginx.conf

EXPOSE 80/tcp
EXPOSE 443/tcp

CMD ["nginx", "-g", "daemon off;"] 