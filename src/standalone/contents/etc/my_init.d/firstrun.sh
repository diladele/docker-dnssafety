#!/bin/bash
set -e

if ! [[ -z "$TIME_ZONE" ]]; then
    sed -i "s:TIME_ZONE = '.*':TIME_ZONE='$TIME_ZONE':" /opt/dnssafety-ui/var/console/console/settings.py
fi
