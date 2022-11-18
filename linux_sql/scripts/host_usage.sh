#!/bin/bash

#Set up arguments
psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

#check number of arguments
if [ $# -ne 5 ]; then
  echo 'Error: enter the correct number of args'
  exit 1
fi

#Save machine statistics to variables
vmstat_disk=$(vmstat -d)
vmstat_mb=$(vmstat --unit M)
disk_info=$(df -BM)

#Usage Variables
hostname=$(hostname -f)
memory_free=$(echo "$vmstat_mb" | awk '{print $4}'| tail -n1 | xargs)
cpu_idle=$(echo "$vmstat_mb" | awk '{print $15}'| tail -n1 | xargs)
cpu_kernel=$(echo "$vmstat_mb" | awk '{print $15}' | tail -n1 | xargs)
disk_io=$(echo "$vmstat_disk" | awk '{print $10}' | tail -n1 | xargs)
disk_available=$(echo "$disk_info" | awk '{print $4}' | tail -n1 | xargs)
disk_available="${disk_available::-1}"
timestamp=$(vmstat -t | awk '{print $18,$19}' | tail -n1 | xargs)

#Subquery to find matching id in host_info table.
host_id="(SELECT id FROM host_info WHERE hostname='$hostname')"

#Inserts server usage data into host_usage table
insert_stmt="INSERT INTO host_usage(
    timestamp,
    host_id,
    memory_free,
    cpu_idle,
    cpu_kernel,
    disk_io,
    disk_available
    )VALUES(
       '$timestamp',
        $host_id,
        $memory_free,
        $cpu_idle,
        $cpu_kernel,
        $disk_io,
        $disk_available)"

export PGPASSWORD=$psql_password
#Insert date into a database
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
exit $?

