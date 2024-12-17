#!/bin/bash

URL=$1

if [ -z "$URL" ]; then
  echo "Usage: $0 <URL>"
  exit 1
fi

echo "Metrics for: $URL"
curl -o /dev/null -s -w "\
HTTP Status Code: %{http_code}\n\
DNS Lookup Time: %{time_namelookup}s\n\
TCP Connection Time: %{time_connect}s\n\
TLS Handshake Time: %{time_appconnect}s\n\
Time to First Byte (TTFB): %{time_starttransfer}s\n\
Total Time: %{time_total}s\n\
Downloaded Size: %{size_download} bytes\n" "$URL"

