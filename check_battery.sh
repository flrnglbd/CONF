#!/bin/bash

kill -15 $(cat ($pwd)/.pid)

while true
do
	battery_level=$(echo $(acpi -b | cut -d',' -f2 |  tr -dc "0-9"))
	charge_or_discharge=$(echo $(acpi -b | cut -d',' -f1 | cut -d':' -f2 | head -c 2))

	if [ $battery_level -le 20 ] && [ $charge_or_discharge = "D" ]; then
		i3-nagbar -t error -m 'I WILL DIE SOON.......'
	fi

    if [ $battery_level -eq 100 ] && [ $charge_or_discharge != "D" ]; then
        i3-nagbar -t warning -m 'I AM FULL UNPLUG ME'
    fi

	sleep 300 # 300 seconds or 5 minutes
done
