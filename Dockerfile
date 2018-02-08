FROM centos:7
MAINTAINER dangkiena3@gmail.com



RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

RUN yum -y update && \ 
    yum -y install make automake gcc gcc-c++ \
    yum -y install GeoIP GeoIP-devel rpm-build rsync \
    yum -y install ruby rubygems ruby-devel && \
    gem install fpm
