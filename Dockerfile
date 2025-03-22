# Use CentOS latest as the base image
FROM centos:latest

# Maintainer information
MAINTAINER prashant52rocks@gmail.com

# Change the base URL for CentOS repo to use vault for older versions
RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' CentOS-*

# Install necessary packages (httpd, zip, unzip)
RUN yum install -y httpd zip unzip && \
    yum clean all

# Download and extract the template into the web server directory
ADD https://www.free-css.com/assets/files/free-css-templates/download/page2/photobusiness.zip /var/www/html/

# Set the working directory to /var/www/html
WORKDIR /var/www/html/

# Unzip the template and clean up unnecessary files
RUN unzip photobusiness.zip && \
    cp -rvf photobusiness/* . && \
    rm -rf photobusiness photobusiness.zip

# Expose port 80 for the web server
EXPOSE 80

# Start the Apache HTTP server in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

 
# FROM  centos:latest
# MAINTAINER trainings.anil@gmail.com
# RUN yum install -y httpd \
#  zip\
#  unzip
# ADD https://www.free-css.com/assets/files/free-css-templates/download/page265/shine.zip /var/www/html/
# WORKDIR /var/www/html/
# RUN unzip shine.zip
# RUN cp -rvf shine/* .
# RUN rm -rf shine shine.zip
# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
# EXPOSE 80   
