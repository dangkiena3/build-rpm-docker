echo "Checking Image centos:centos7"
echo "THIS FRESH CENTOS6 CONTAINER WILL BE  AUTOMATICALLY DESTROYED AFTER EXIT"

docker run -it --rm -v `pwd`:/build --name rpm_checker --dns=8.8.8.8 centos:centos7 /bin/bash
