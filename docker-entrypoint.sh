#!/bin/bash
set -e

# Vertica should be shut down properly
function shut_down() {
  echo "Shutting Down"
  gosu dbadmin /opt/vertica/bin/admintools -t stop_db -d docker -i
  exit
}

trap "shut_down" SIGKILL SIGTERM SIGHUP SIGINT EXIT

chown -R dbadmin:verticadba "$VERTICADATA"

if [ -z "$(ls -A "$VERTICADATA")" ]; then
  echo "Creating database"
  gosu dbadmin /opt/vertica/bin/admintools -t drop_db -d docker
  gosu dbadmin /opt/vertica/bin/admintools -t create_db -s localhost -d docker -c /home/dbadmin/docker/catalog -D /home/dbadmin/docker/data
else
  gosu dbadmin /opt/vertica/bin/admintools -t start_db -d docker -i
fi

echo "Vertica is now running"

while true; do
  sleep 1
done
