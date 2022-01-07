# Linux Cluster Monitoring Agent

# Introduction
The objective of the Linux Cluster Monitoring Agent is to record the hardware specifications of each node and monitor node resource usages (eg CPU/memory) in real time. The Linux Cluster Administration (LCA) team manages 10 nodes each running CentOS 7. The MVP is developed through the use of bash scripts, docker, postgreSQL, and git. The bash scripts are used to record data on each server and send it to the postreSQL database. The database is provisioned using docker and through the use of `crontab` at least 3 updates will be given in 5 minute intervals. This will assist the LCA team in decisions regarding allocating resources. 
