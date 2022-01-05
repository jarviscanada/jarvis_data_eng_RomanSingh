#!/bin/bash

#Set up arguments
psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

#check number of arguments
if [ $# -ne 5 ]; then
  echo "Enter the correct number of args."
  exit 1
fi

#save number of CPU to a variable
lscpu_out=`lscpu`

#Save machine statistics
vmstat_mb=$(vmstat --unit M)
mem_info=$(cat /proc/meminfo)

#Hardware specification variables
hostname=$(hostname -f)
cpu_number=$(echo "$lscpu_out" | grep -E "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture= $(echo "$lscpu_out"  | egrep "Architecture:" | awk '{print $2}' | xargs)
cpu_model= $(echo "$lscpu_out"  | egrep "^Model name:" | awk '{print $3 $4 $5 $6 $7}' | xargs)
cpu_mhz= $(echo "$lscpu_out"  | egrep "^CPU MHz:" | awk '{print $3}' | xargs)
l2_cache= $(echo "$lscpu_out"  | egrep "^L2 cache:" | awk '{print $3}' | xargs)
total_mem=$(echo "$mem_info"  | egrep "^MemTotal:" | awk '{print $2}' | xargs)
timestamp= $(vmstat -t | tail -n1 | awk '{print $18, $19}' | xargs)

#Find matching id in host_info table
host_id="(SELECT id FROM host_info WHERE hostname='$hostname')";

#Insert into PSQL host_info.
insert_stmt="INSERT INTO PUBLIC.host_info(timestamp, total_mem, l2_cache, cpu_mhz, cpu_model, cpu_architecture, cpu_number, hostname )
VALUES('$timestamp', '$total_mem', '$l2_cache', '$cpu_mhz', '$cpu_model', '$cpu_architecture', '$cpu_number', '$hostname')"

#env variable for psql command
export PGPASSWORD=$psql_password

#Insert data into a database
psql -h $psql -p $psql_port -d $db_name -U $psql_user -c "insert_stmt"
exit $?


