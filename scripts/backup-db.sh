flyctl proxy 5432:5432 -a picoquotes-db &

sleep 5

pg_dump -h localhost -p 5432 -U picoquotes -d picoquotes -Fc > db.backup

echo Backed up to db.backup
echo \(Note, \"flyctl proxy\" is still running in the background -- it should be killed\)
