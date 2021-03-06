# Logstash
#
# logstash is a tool for managing events and logs
#
# VERSION               1.3.3

FROM      ubuntu:14.04
MAINTAINER Deni Bertovic "deni@kset.org"

ENV DEBIAN_FRONTEND noninteractive

# What tag to use for lumberjack
ENV LUMBERJACK_TAG MYTAG

# Number of elasticsearch workers
ENV ELASTICWORKERS 1

RUN apt-get update
RUN apt-get install -y wget openjdk-6-jre
RUN wget https://download.elasticsearch.org/logstash/logstash/logstash-1.3.3-flatjar.jar -O /opt/logstash.jar --no-check-certificate 2>/dev/null

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

EXPOSE 514/udp
EXPOSE 5043
EXPOSE 5228/udp
EXPOSE 9200
EXPOSE 9292
EXPOSE 9300

CMD /usr/local/bin/run.sh
