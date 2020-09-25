#!/bin/bash

source /scripts/env

DATE=`date +%Y-%m-%d`
MONTH=$(date +%B)
YEAR=$(date +%Y)
if [ "${S3_BUCKET_PREFIX}" ]; then
  S3_BUCKET_PREFIX="${S3_BUCKET_PREFIX}/"
fi
KEY_PREFIX="${S3_BUCKET_PREFIX}${YEAR}/${MONTH}"
KEY=${KEY_PREFIX}/${DBNAME}_${DATE}.dmp

echo "Dump users and permisions to s3://${S3_BUCKET}/${S3_BUCKET_PREFIX}globals.dmp" 
pg_dumpall --globals-only | aws s3 cp - s3://${S3_BUCKET}/${S3_BUCKET_PREFIX}globals.dmp

echo "Backing up ${DBNAME} to s3://${S3_BUCKET}/${KEY}" 
pg_dump -Fc ${DBNAME} | aws s3 cp - s3://${S3_BUCKET}/${KEY}
