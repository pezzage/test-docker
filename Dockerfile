FROM haproxy:1.8.14-alpine as haproxy

FROM httpd:2.4.37-alpine as default
COPY ./index.html  /usr/local/apache2/htdocs/

FROM httpd:2.4.37-alpine as service-1
RUN mkdir -p /usr/local/apache2/service-1/service-1
RUN echo '' > /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo '<VirtualHost *:80>' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'DocumentRoot /usr/local/apache2/service-1' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo '<Directory /usr/local/apache2/service-1/>' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'Options Indexes FollowSymLinks' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'AllowOverride All' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'Require all granted' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo '</Directory>' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'ErrorLog /usr/local/apache2/main-error.log' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'LogLevel warn' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'CustomLog /usr/local/apache2/main-access.log combined' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo '</VirtualHost>' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'Include conf/extra/httpd-vhosts.conf' >> /usr/local/apache2/conf/httpd.conf
RUN chmod -R +x /usr/local/apache2/service-1
COPY ./service-html/index-service-1.html    /usr/local/apache2/service-1/service-1/index.html

FROM httpd:2.4.37-alpine as service-2
RUN mkdir -p /usr/local/apache2/service-2/service-2 
RUN echo '' > /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo '<VirtualHost *:80>' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'DocumentRoot /usr/local/apache2/service-2' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo '<Directory /usr/local/apache2/service-2/>' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'Options Indexes FollowSymLinks' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'AllowOverride All' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'Require all granted' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo '</Directory>' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'ErrorLog /usr/local/apache2/main-error.log' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'LogLevel warn' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'CustomLog /usr/local/apache2/main-access.log combined' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo '</VirtualHost>' >> /usr/local/apache2/conf/extra/httpd-vhosts.conf \
&& echo 'Include conf/extra/httpd-vhosts.conf' >> /usr/local/apache2/conf/httpd.conf
RUN chmod -R +x /usr/local/apache2/service-2
COPY ./service-html/index-service-2.html    /usr/local/apache2/service-2/service-2/index.html
COPY ./service-html/index-service-2.html    /usr/local/apache2/service-2/index.html
