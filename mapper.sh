#!/bin/bash

# Start the run once job.
echo "mapper container has been started"

# Setup a cron schedule
echo "*/10 * * * * /usr/local/src/Minecraft-Overviewer/overviewer.py /world /output >> /var/log/cron.log 2>&1
# This extra line makes it a valid cron" > scheduler.txt

crontab scheduler.txt
cron
touch /var/log/cron.log
tail -f /var/log/cron.log