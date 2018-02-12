FROM centos:7
#update and install dependencies
RUN yum update -y && yum clean all
RUN yum install wget rsync -y
RUN wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -ivh epel-release-latest-7.noarch.rpm
RUN yum install inotify-tools -y
RUN mkdir -p dropbox/images
RUN mkdir -p data/images
# Copy rsync script into image
COPY rsync.sh .
# Run the script
CMD sh rsync.sh
