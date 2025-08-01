#! /usr/bin/bash

# Define a log file path
LOG_FILE="/script_log.txt"

# Log the start time of the script
echo "$(date): Script started" >> "$LOG_FILE"

source /home/pawel/github/Home.Configuration/Prism.env

echo $ENV_PHOTOPRISM_DATABASE_PASSWORD >> "$LOG_FILE"
echo "pawel"
echo $ENV_PHOTOPRISM_DATABASE_PASSWORD

mysql --user="root" --password=$ENV_PHOTOPRISM_DATABASE_PASSWORD --database="photoprism" --execute="update albums a
inner join photos p on a.album_path=p.photo_path
inner join files f on p.id=f.photo_id
set thumb=convert(f.file_hash, char(200)),thumb_src='manual', album_order='name'
where convert(album_type, char(100))='folder'
and convert(p.photo_name, char(200)) like '%Cover%';"

echo "$(date): Script finished" >> "$LOG_FILE