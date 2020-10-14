#!/bin/bash
#
# Reloads Dns Safety, usually called by the Web UI
#
# returns:
#        0 - on success
#       !0 - on various errors
#

echo "Reloading Dns Safety Daemon..."
sv hup dsdnsd

# dump success
echo "Reload successful!"
exit 0
