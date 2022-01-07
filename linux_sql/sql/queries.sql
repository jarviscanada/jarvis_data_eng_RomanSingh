-- Query One Group hosts by CPU number and sort by their memory size in descending order(within each cpu_number group)

SELECT cpu_number, id as host_id, total_mem
GROUP BY cpu_number, id
ORDER BY  total_mem DESC;

-- Query Two Average used memory in percentage over 5 mins interval for each host
host_agent=# SELECT host_usage.host_id,
host_info.hostname,
round5(host_usage.timestamp),
AVG(((host_info.total_mem - host_usage.memory_free)/(host_info.total_mem))*100) as avg_used_mem_percentage
FROM host_usage, host_info
WHERE host_usage.host_id = host_info.id
GROUP BY round5(host_usage.timestamp),
host_usage.host_id,
host_info.hostname,
host_info.total_mem
ORDER BY host_usage.host_id,
round5(host_usage.timestamp);


-- Query 3 Crontab host failure detection
SELECT host_id,
round5(timestamp) as timestamp,
COUNT(*) AS num_data_points
FROM host_usage
GROUP BY host_id, round5(timestamp)
HAVING COUNT(*)<3
ORDER BY host_id;
