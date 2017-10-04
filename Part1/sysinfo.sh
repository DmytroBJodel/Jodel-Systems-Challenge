#!/bin/bash

# This script created as a part of Jodel systems chalenge
# List of system info to print

UPTIME=`uptime`
MEM=`free -m`
DISK=`df -h`
KERNEL=`uname -rms`
NETWORK=`ss -a`
PROCS=`ps aux`

# Generating html with data
echo "Content-type: text/html"
 echo ""
 echo "<html><head><title>Jodel Systems Challendge!</title></head><body>"
 echo "Print system info! <br />" 
 echo "Uptime is: <br />"
 echo "<pre>$UPTIME</pre>"
 echo "Memory usage is: <br />"
 echo "<pre>$MEM</pre>"
 echo "Disk usage is:  <br />"
 echo "<pre>$DISK</pre>"
 echo "Kernel version is: <br />"
 echo "<pre>$KERNEL</pre>"
 echo "Network connections: <br />"
 echo "<pre>$NETWORK</pre>"
 echo "Running processes: <br />"
 echo "<pre>$PROCS</pre>"
echo "</body></html>"
