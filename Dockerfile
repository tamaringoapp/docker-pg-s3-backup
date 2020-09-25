FROM postgres:12.1

RUN apt-get -y update; apt-get -y --no-install-recommends install postgresql-client cron awscli

COPY scripts /scripts
RUN chmod 0755 /scripts/*.sh

ENTRYPOINT ["/bin/bash", "/scripts/start.sh"]
