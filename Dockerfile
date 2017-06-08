# Use an official Alpine runtime as a base image
FROM alpine:3.6

# ====================Installing Prereqs====================
ENV APACHE_VERSION 2.4.25-r1
ENV PHP_VERSION 7.1.5-r0
ENV MEDIAWIKI_URL https://releases.wikimedia.org/mediawiki/1.29/mediawiki-1.29.0-rc.0.tar.gz

#RUN apk update
RUN apk add --no-cache apache2=$APACHE_VERSION
#RUN apk add curl \
#			php7=$PHP_VERSION \
#			php7-session=$PHP_VERSION \
#			php7-json=$PHP_VERSION \
#			php7-mbstring=$PHP_VERSION \
#			php7-intl=$PHP_VERSION \
#			php7-openssl=$PHP_VERSION \
#			php7-mysqlnd=$PHP_VERSION  \
#			php7-mysqli=$PHP_VERSION \
#			php7-xml=$PHP_VERSION \
#			php7-curl=$PHP_VERSION

# ====================Configuration====================

# Apache
RUN mkdir /run/apache2
ADD ./apache2/httpd.conf /etc/apache2/httpd.conf


# ====================Application====================

#Download MediaWiki
ADD $MEDIAWIKI_URL /tmp/mediawiki.tar.gz

#Extract MediaWiki to Application Folder
RUN mkdir -p /var/www/localhost/htdocs/mediawiki/
RUN tar -xzf /tmp/mediawiki.tar.gz -C /var/www/localhost/htdocs/mediawiki  --strip-components=1 
RUN rm -f /tmp/mediawiki.tar.gz


# ====================Container Settings====================

# Make port 80 available to the world outside this container
EXPOSE 80

# Run app.py when the container launches
CMD ["httpd", "-DFOREGROUND"]