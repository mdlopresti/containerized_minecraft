#!/bin/bash

# Start the run once job.
echo "backup container has been started"

mkdir /backup/hourly
mkdir /backup/daily
mkdir /backup/weekly

# Setup a cron schedule
echo '0 * * * * datetime=$(date +"%Y%m%d%H%M%S") && echo "created /backup/hourly/$datetime.tar.gz" >> /var/log/cron.log 2>&1 && tar -czvf "/backup/hourly/$datetime.tar.gz" /world >> /var/log/cron.log 2>&1
5 * * * * find /backup/hourly | grep -v "/$" | tail -n +26 | xargs -I {} rm -- {}
0 0 * * * datetime=$(date +"%Y%m%d%H%M%S") && echo "created /backup/daily/$datetime.tar.gz" >> /var/log/cron.log 2>&1 && tar -czvf "/backup/daily/$datetime.tar.gz" /world >> /var/log/cron.log 2>&1
5 0 * * * find /backup/daily | grep -v "/$" | tail -n +9 | xargs -I {} rm -- {}
0 0 * * 0 datetime=$(date +"%Y%m%d%H%M%S") && echo "created /backup/weekly/$datetime.tar.gz" >> /var/log/cron.log 2>&1 && tar -czvf "/backup/weekly/$datetime.tar.gz" /world >> /var/log/cron.log 2>&1
5 0 * * 0 find /backup/weekly | grep -v "/$" | tail -n +10 | xargs -I {} rm -- {}
# This extra line makes it a valid cron' > scheduler.txt

crontab scheduler.txt
cron
touch /var/log/cron.log
tail -f /var/log/cron.log