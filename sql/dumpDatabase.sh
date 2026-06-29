mysqldump --host=localhost --user=root -p \
  --single-transaction \
  --routines --triggers --events \
  --set-gtid-purged=OFF \
  --databases your_database_name > onprem_dump.sql
