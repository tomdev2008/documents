FROM centos:centos6

MAINTAINER base centos6 build image, <cgl@meitu.com>

# Install yum dependencies
RUN yum -y update && \
    yum groupinstall -y development && \
    yum install -y \
        tar \
        wget \
        bzip2-devel \
    	git \
    	hostname \
    	openssl \
    	openssl-devel \
    	sqlite-devel \
    	sudo \
    	zlib-dev \
        tkinter \
        tk-devel

# Install gcc4.8
RUN curl -Lks http://www.hop5.in/yum/el6/hop5.repo > /etc/yum.repos.d/hop5.repo && \
	yum install -y \
        gcc \
        gcc-g++

# Install python2.7
RUN cd /tmp && \
    wget https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz && \
    tar xvfz Python-2.7.8.tgz && \
    cd Python-2.7.8 && \
    ./configure --prefix=/usr/local && \
    make && \
    make altinstall

# Install setuptools + pip
RUN wget https://bootstrap.pypa.io/ez_setup.py && \
    python2.7 ez_setup.py && \
    easy_install-2.7 pip && \
    pip2.7 install --upgrade pip

# Install tornado
RUN pip install tornado

# Install fbprophet
RUN pip install fbprophet

# port
EXPOSE 9090
