FROM centos:7
MAINTAINER Bryan Ross

# Install Node.js
RUN curl -sL https://rpm.nodesource.com/setup_4.x | bash -
RUN yum install -y nodejs

# Bootstrap latest NPM version
RUN npm install -g npm

# Required to rebuild some NPM modules
RUN yum install -y make gcc-c++ libicu-devel

# Install dependencies first for more efficient docker layering
COPY package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /opt/hubot && cp -a /tmp/node_modules /opt/hubot/

WORKDIR /opt/hubot

# Default config files
COPY package.json          /opt/hubot/package.json
COPY external-scripts.json /opt/hubot/external-scripts.json
RUN mkdir                  /opt/hubot/scripts

# You can mount your own hubot scripts directory here
VOLUME ["/opt/hubot/scripts"]

# You can mount your own hubot config here
VOLUME ["/opt/hubot/conf"]

# Wrapper for setting user-supplied config
COPY run /opt/hubot/run

# Hubot web server
ENV PORT 8080
EXPOSE ${PORT}

ENV PATH /opt/hubot/node_modules/.bin/:$PATH
ENV PATH /opt/hubot/node_modules/hubot/node_modules/coffee-script/bin/:$PATH

ENTRYPOINT ["/opt/hubot/run"]
