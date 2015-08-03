FROM debian:jessie

# add jessie-backports
RUN echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list.d/sources.list

# setup mackerel-agent
RUN apt-get update \
  && apt-get -y install docker.io \
  && apt-get -y install curl sudo ruby \
  && curl -fsSL https://mackerel.io/assets/files/scripts/setup-apt.sh | sh \
  && apt-get update \
  && apt-get -y install mackerel-agent mackerel-agent-plugins \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# setup docker plugin
COPY mackerel-plugin-docker.rb /mackerel-plugin-docker.rb
RUN echo [plugin.metrics.docker] >> /etc/mackerel-agent/mackerel-agent.conf
RUN echo command = \"ruby /mackerel-plugin-docker.rb\" >> /etc/mackerel-agent/mackerel-agent.conf

ADD startup.sh /startup.sh
RUN chmod 755 /startup.sh

# boot mackerel-agent
CMD ["/startup.sh"]
