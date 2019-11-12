# Use CentOS Official image to build it
FROM centos:latest


# My datainfo
MAINTAINER Álvaro Castillo sincorchetes@gmail.com


# Setup dependencies and some tools
RUN dnf install npm bzip2 git fontconfig freetype freetype-devel fontconfig-devel libstdc++ -y


# Copy PhantomJS to webogram
COPY phantomjs-2.1.1-linux-x86_64.tar.bz2 /


# Copy script to run npm after
COPY start-webogram.sh /usr/local/bin/


# Exposing port
EXPOSE 8000


# Launching web apps and some settings up 
RUN cd /opt && git clone https://github.com/zhukov/webogram && tar xfv /phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /opt/ && mv /opt/phantomjs-2.1.1-linux-x86_64 /opt/phantomjs && ln -s /opt/phantomjs/bin/phantomjs /usr/bin/phantomjs && cd /opt/webogram && npm install && npm audit fix --force


# Run command as daemon
CMD ["/usr/local/bin/start-webogram.sh"]
