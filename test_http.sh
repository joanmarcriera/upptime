#!/bin/bash +x

# URLs to monitor
HTTP_URL="http://ftp.ebi.ac.uk/robots.txt"
HTTPS_URL="https://ftp.ebi.ac.uk/robots.txt"

# Function to monitor a URL
monitor_http() {
  local url=$1
  echo "Monitoring $url"

  # Perform the download and capture metrics
  wget_output=$(wget --server-response -O /dev/null "$url" 2>&1)


  echo "$wget_output"


  # Extract metrics
  http_code=$(echo "$wget_output" | egrep "HTTP/" | tail -1 | awk '{print $2}')
  ttfb=$(echo "$wget_output" | egrep -i "HTTP/" -A 6 | egrep "^[ ]*0" | awk '{print $1}')
  download_speed=$(echo "$wget_output" | egrep -oP '\(\K[0-9\.]+ [KMGT]?B/s')

  # Display metrics
  echo "HTTP Status Code: $http_code"
  echo "Time to First Byte (TTFB): $ttfb seconds"
  echo "Download Speed: $download_speed"
  echo "-----------------------------------"
}

# Monitor HTTP and HTTPS URLs
monitor_http $HTTP_URL
monitor_http $HTTPS_URL

