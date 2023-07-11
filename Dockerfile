FROM php:apache 
COPY . /var/www/html/

#Install
RUN apt update && apt install -y libapache2-mod-perl2 libapache2-mod-perl2-dev libcgi-pm-perl liblocal-lib-perl
RUN a2enmod cgid

#Edit apache
RUN echo "<Directory /var/www/html/>" >> /etc/apache2/apache2.conf
RUN echo "Options ExecCGI Includes Indexes FollowSymlinks" >> /etc/apache2/apache2.conf
RUN echo "DirectoryIndex index.pl index.html index.htm index.php" >> /etc/apache2/apache2.conf
RUN echo "AddHandler cgi-script .cgi .pl" >> /etc/apache2/apache2.conf
RUN echo "</Directory>" >> /etc/apache2/apache2.conf

#sets the execute permission
RUN chmod +x /var/www/html/index.pl
