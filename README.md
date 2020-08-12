# Let's run Minecraft in Containers

The goal of this project is to create a containerized minecraft app that does the following

1. ~~Runs minecraft java edition server~~
2. Runs the [equivalent exchange mod](https://github.com/sinkillerj/ProjectE)
3. Compile forge in base image
4. ~~Runs the [minecraft overviewer](https://github.com/overviewer/Minecraft-Overviewer) mapper~~
5. ~~Automagic backup the backup~~

## Map/Web
The mapper service runs a cron that runs [minecraft overviewer](https://github.com/overviewer/Minecraft-Overviewer) every 10 minutes.  The files from that process are saved to a voume that is shared to the web service.  That service runs nginx and makes the map available on port 80

## Backup
Backups are handled by a cron in the backups service.  Backups follow the following schedule.
#### Hourly
Hourly backups run at the top of each hour.  24 hourly backups are retained.  
#### Daily
Daily backups are ran at 00:05:00 each day.  7 daily backups are retained.  
#### Weekly
Weekly backups are ran sundays at 00:10:00.  8 weekly backups are retained.  