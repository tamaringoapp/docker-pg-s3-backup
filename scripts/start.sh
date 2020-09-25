#!/bin/bash

PG_ENV="/scripts/env"
if [[ -f "${PG_ENV}" ]]; then
	rm ${PG_ENV}
fi

if [ -z "${POSTGRES_PORT}" ]; then
  PGPORT=5432
fi

echo "
export PGHOST=\"$PGHOST\"
export PGPORT=\"$PGPORT\"
export PGUSER=\"$PGUSER\"
export PGPASSWORD=\"$PGPASSWORD\"
export DBNAME=\"$DBNAME\"
export S3_BUCKET=\"$S3_BUCKET\"
export S3_BUCKET_PREFIX=\"$S3_BUCKET_PREFIX\"
 " > ${PG_ENV}

# Use AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY if present.
# We need to do this conditionaly, in the case we are using an EC2 Instance role
if [ "${AWS_ACCESS_KEY_ID}" ] && [ "$AWS_SECRET_ACCESS_KEY" ]; then
echo "
export AWS_ACCESS_KEY_ID=\"$AWS_ACCESS_KEY_ID\"
export AWS_SECRET_ACCESS_KEY=\"$AWS_SECRET_ACCESS_KEY\"
" >> ${PG_ENV}
fi

if [[ $DEBUG == "True" ]]; then
  cat $PG_ENV
fi

if [ -z "${CRON}" ]; then
  # Everyday at 00:00
  CRON="0 0 * * *"
fi

job="
# execute backup
$CRON /scripts/backup.sh > /proc/1/fd/1 2>&1
"
# Save the cron job
echo "$job" | crontab -

cron -f
