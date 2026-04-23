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

# Detect database client
if command -v mariadb &> /dev/null; then
    DB_CLIENT="mariadb"
elif command -v mysql &> /dev/null; then
    DB_CLIENT="mysql"
else
    echo "Error: Neither mysql nor mariadb client found." | tee -a "$LOG_FILE"
    exit 1
fi

echo "Connecting to database at $DB_HOST using $DB_CLIENT..." | tee -a "$LOG_FILE"

$DB_CLIENT -h "$DB_HOST" --user="root" --password="$ENV_PHOTOPRISM_DATABASE_PASSWORD" --database="photoprism" --execute="update albums a
inner join photos p on a.album_path=p.photo_path
inner join files f on p.id=f.photo_id
set thumb=convert(f.file_hash, char(200)),thumb_src='manual', album_order='name'
where convert(album_type, char(100))='folder'
and convert(p.photo_name, char(200)) like '%Cover%';"

$DB_CLIENT -h "$DB_HOST" --user="root" --password="$ENV_PHOTOPRISM_DATABASE_PASSWORD" --database="photoprism" --execute="update albums
set album_category=substring_index(album_path,'#',-1)  where album_path <> '' and position('#' in album_path)>0;"

echo "$(date): Script finished" | tee -a "$LOG_FILE"

