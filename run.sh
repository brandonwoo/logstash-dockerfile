#!/bin/bash
ES_HOST=${ES_HOST:-127.0.0.1}
ES_PORT=${ES_PORT:-9300}
EMBEDDED="false"
WORKERS=${ELASTICWORKERS:-1}

if [ "$ES_HOST" = "127.0.0.1" ] ; then
    EMBEDDED="true"
fi

cat << EOF > /opt/logstash.conf
input {
  udp {
    port => 5228
    codec => json_lines
  }
  collectd {typesdb => ["/opt/collectd-types.db"]}
}
output {
  stdout {
      codec => json_lines
  }

  elasticsearch {
      embedded => $EMBEDDED
      host => "$ES_HOST"
      port => "$ES_PORT"
      workers => $WORKERS
  }
}
EOF


exec java -jar /opt/logstash.jar agent -f /opt/logstash.conf -- web
