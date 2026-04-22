#! /bin/bash

# Define a log file path
LOG_FILE="/script_log.txt"
DB_HOST=${DB_HOST:-localhost}

# Log the start time of the script
echo "$(date): Script started" | tee -a "$LOG_FILE"

if [ -f /Prism.env ]; then
    echo "Loading variables from /Prism.env" | tee -a "$LOG_FILE"
    source /Prism.env
else
    echo "No /Prism.env found, using existing environment variables" | tee -a "$LOG_FILE"
fi

echo "Connecting to database at $DB_HOST..." | tee -a "$LOG_FILE"

mysql -h "$DB_HOST" --user="root" --password="$ENV_PHOTOPRISM_DATABASE_PASSWORD" --database="photoprism" --execute="update albums a
inner join photos p on a.album_path=p.photo_path
inner join files f on p.id=f.photo_id
set thumb=convert(f.file_hash, char(200)),thumb_src='manual', album_order='name'
where convert(album_type, char(100))='folder'
and convert(p.photo_name, char(200)) like '%Cover%';"

mysql -h "$DB_HOST" --user="root" --password="$ENV_PHOTOPRISM_DATABASE_PASSWORD" --database="photoprism" --execute="update albums
set album_category=substring_index(album_path,'#',-1)  where album_path <> '' and position('#' in album_path)>0;"

echo "$(date): Script finished" | tee -a "$LOG_FILE"

