#!/bin/bash
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

while true
do
  clear

  echo " ================================ "
  echo "      LINUX SYSTEM MONITOR "
  echo " ================================ "

  echo "Time: $(date)"
  echo ""


  echo " -------------------------------- "
#cpu usage

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "CPU Usage: $CPU%"
if (( ${CPU%.*} > CPU_THRESHOLD ))
then
echo "CPU ALERT!"
echo "$(date) : CPU usage high - $CPU%" >> logs/monitor.sh
fi

  echo " -------------------------------- "
# Memory Usage
MEMORY=$(free | awk '/Mem/ {printf("%.2f"), $3/$2 * 100}')
echo "Memory Usage: $MEMORY%"
if (( ${MEMORY%.*} > MEMORY_THRESHOLD ))
then
echo "MEMORY ALERT!"
echo "$(date) : Memory usage high - $MEMORY%" >> logs/monitor.sh
fi

  echo " --------------------------------- "
# disk usage
DISK=$(df / | awk 'NR==2 {print $5}' | sed 's/%//' )
echo "Disk Usage: $DISK%"
if (( ${DISK%.*} > DISK_THRESHOLD ))
then
echo "DISK ALERT!"
echo "$(date) : disk usage high - $DISK%" >> logs/monitor.sh
fi
  echo " --------------------------------- "

echo ""
echo "Top Processes:"
ps aux | sort -rk 3 | head -6

  sleep 2
done

