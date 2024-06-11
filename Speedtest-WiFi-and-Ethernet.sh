#!/bin/bash

# Define the output file with the current date and time
OUTPUT_FILE="$(date '+%Y-%m-%d_%H-%M-%S')-speedtest-results.txt"

# Function to run speedtest and append results to the output file
run_speedtest() {
  echo "Running speedtest for $1" >> $OUTPUT_FILE
  speedtest-cli >> $OUTPUT_FILE
  echo "" >> $OUTPUT_FILE
}

# Bring down wlan0, run speedtest, then bring wlan0 back up
echo "Bringing down wlan0 interface..."
sudo ifconfig wlan0 down
run_speedtest "eth0"
echo "Bringing up wlan0 interface..."
sudo ifconfig wlan0 up

# Bring down eth0, wait 5 seconds, run speedtest, then bring eth0 back up
echo "Bringing down eth0 interface..."
sudo ifconfig eth0 down
sleep 5
run_speedtest "wlan0"
echo "Bringing up eth0 interface..."
sudo ifconfig eth0 up

echo "Speed tests completed. Results saved in $OUTPUT_FILE"
