#!/bin/sh

# gpio connected momentary switch system halt button script. 
# 'gpio' command requires WiringPi: sudo apt-get install wiringpi
# Probably are smarter / more battery efficient ways to do this
# but you can get this script going very easily and running with a cheap switch

# Configurable stuff...
HALT=21                # Halt button GPIO pin (other end to GND)

gpio -g mode $HALT up  # Initialize GPIO states

while : # Forever
do
	currenttime=$(date +%s)
        # Check for halt button -- hold >= 2 sec
        while [ $(gpio -g read $HALT) -eq 0 ]; do
                if [ $(($(date +%s)-currenttime)) -ge 2 ]; then
                        shutdown -h now
                fi
        done
done
