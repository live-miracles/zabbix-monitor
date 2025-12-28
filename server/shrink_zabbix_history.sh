#!/bin/bash

# Load MySQL credentials from ~/.my.cnf
export PT_TOOLKIT_DSN="--defaults-file=~/.my.cnf"

# Tables to shrink
tables=("history_text" "history" "history_uint")

for t in "${tables[@]}"; do
  echo "Shrinking table $t..."
  pt-online-schema-change \
    --alter "ENGINE=InnoDB" \
    D=zabbix,t=$t \
    --execute \
    --chunk-size=50000 \
    --critical-load Threads_running=25 \
    --no-check-slave
done
