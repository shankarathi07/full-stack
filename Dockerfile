FROM registry.redhat.io/rhel8/nodejs-14
ENV https_proxy http://10.3.0.3:3128
ENV http_proxy http://10.3.0.3:3128
WORKDIR /usr/src/app

USER 0
RUN yum install sudo -y
RUN sudo yum update
RUN dnf install gcc
RUN yes | dnf install python2
# RUN dnf install numactl-devel
#RUN dnf install ftp://ftp.pbone.net/mirror/ftp.redhat.com/pub/redhat/rhel/rhel-8-beta/baseos/x86_64/Packages/pam-devel-1.3.1-3.el8.x86_64.rpm
#RUN dnf install pam-devel
RUN sudo yum install numactl-libs
# RUN dnf install https://download.opensuse.org/ports/ppc/source/tumbleweed/repo/oss/src/numactl-2.0.14-4.2.src.rpm
# RUN dnf install numactl-devel
# RUN yes | sudo yum install unixODBC unixODBC-devel 
# RUN sudo yum install devtoolset-8
# RUN scl enable devtoolset-8 bash
# RUN sudo yum install libnuma-dev

COPY . /usr/src/app
RUN npm install --unsafe-perm ibm_db
RUN npm install
RUN chown -R 1001:0 /usr/src/app
USER 1001
CMD ["npm", "start"]
EXPOSE 3000
