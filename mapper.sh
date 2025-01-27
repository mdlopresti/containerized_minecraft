#!/bin/bash

# Start the run once job.
echo "Docker container has been started"

# Setup a cron schedule
echo "*/5 * * * * /usr/local/src/Minecraft-Overviewer/overviewer.py /world /output >> /var/log/cron.log 2>&1
# This extra line makes it a valid cron" > scheduler.txt

crontab scheduler.txt
cron
touch /var/log/cron.log
tail -f /var/log/cron.log