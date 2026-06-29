# remember to add SET SESSION sql_generate_invisible_primary_key = OFF; to onprem_dump.sql

mysql --host=gar-mysql-licenses.mysql.database.azure.com \
  --user=gar -p \
  --ssl-mode=REQUIRED \
  --init-command="SET SESSION foreign_key_checks=0, unique_checks=0;" \
  < onprem_dump.sql
