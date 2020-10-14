#!/bin/bash
#
# Reloads Web Safety and Squid Proxy, usually called by the Web UI
#
# returns:
#        0 - on success
#       !0 - on various errors
#

echo "Restarting Dns Safety Daemon..."
sv restart dsdnsd

# dump success
echo "Restart successful!"
exit 0
