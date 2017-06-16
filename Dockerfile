# Use an official Alpine runtime as a base image
FROM alpine:3.6

# ====================Installing Prereqs====================
ENV APACHE_VERSION 2.4.25-r1
ENV PHP_VERSION 7.1.5-r0
ENV MEDIAWIKI_URL https://releases.wikimedia.org/mediawiki/1.28/mediawiki-1.28.2.tar.gz
ENV WEB_ROOT /var/www/localhost/htdocs

RUN apk add --no-cache \
			apache2=$APACHE_VERSION \
			curl \
			php7=$PHP_VERSION \
			php7-session=$PHP_VERSION \
			php7-json=$PHP_VERSION \
			php7-mbstring=$PHP_VERSION \
			php7-intl=$PHP_VERSION \
			php7-openssl=$PHP_VERSION \
			php7-mysqlnd=$PHP_VERSION  \
			php7-mysqli=$PHP_VERSION \
			php7-xml=$PHP_VERSION \
			php7-curl=$PHP_VERSION \
			php7-apache2=$PHP_VERSION \
			php7-ctype=$PHP_VERSION \
			php7-iconv=$PHP_VERSION \
			php7-dom=$PHP_VERSION \
			php7-xmlreader=$PHP_VERSION \
			imagemagick=7.0.5.10-r0 \
			diffutils=3.5-r0

# ====================Configuration====================

# Apache
RUN mkdir /run/apache2

# ====================Application====================

#Download MediaWiki
ADD $MEDIAWIKI_URL /tmp/mediawiki.tar.gz

#Extract MediaWiki to Application Folder
RUN mkdir -p $WEB_ROOT/mediawiki/
RUN tar -xzf /tmp/mediawiki.tar.gz -C $WEB_ROOT/mediawiki  --strip-components=1 
RUN chown -R apache. $WEB_ROOT
RUN rm -f /tmp/mediawiki.tar.gz


# ====================Container Settings====================

# Make port 80 available to the world outside this container
EXPOSE 80

# Run app.py when the container launches
CMD ["httpd", "-DFOREGROUND"]