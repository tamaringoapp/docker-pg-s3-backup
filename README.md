Backs up a Postgres database to S3.

# Env vars

| name | default | description |
|----|-----------|-------------|
| CRON | `0 0 * * *` | A cron expression for when the backups should be made. |
| PGHOST | - | The host of the db | 
| PGPORT | `5432` | Db Port |
| DBNAME | - | The database to backup |
| PGUSER | - | The username to use |
| PGPASSWORD | - | The password for the given user |
| S3_BUCKET | - | The destination S3 bucket where to save the files |
| S3_BUCKET_PREFIX | - | A prefix where to save the files |
| DEBUG | - | When `True`, will show debug information in the console. ⚠️ This will expose your secrets (passwords, etc) int the logs. | 

# About AWS credientials

In order to save files to a private bucket, you will need to authenticate. 
If you are running this Docker image from an EC2 instance,
you can attach an ec2 IAM role with sufficient permissions ro write to your s3 bucket.
Alternatively, you can pass the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables.

# Credits

Inspired from https://github.com/kartoza/docker-pg-backup
