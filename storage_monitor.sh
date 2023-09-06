#!/bin/bash

# Define the directory you want to monitor
DIRECTORY=${1}

# Define the interval in seconds (5 minutes = 300 seconds)
INTERVAL=${2}

# Define the screen session name where your program is running
SCREEN_SESSION=${3}

# Define the log file to store the directory sizes
LOG_FILE=storage-monitor.log

# Function to calculate and log directory size
calculate_directory_size() {
  while true; do
    # Use 'du' to calculate the size of the directory in human-readable format
    dir_size=$(du -shG "$DIRECTORY" | awk '{print $1}')
    
    # Get the current date/time
    current_datetime=$(date +%F\ %T)
    
    # Log the current date/time and directory size to the log file
    echo "$current_datetime: Directory size in $DIRECTORY is $dir_size" >> "$LOG_FILE"
    
    # Sleep for the specified interval
    sleep $INTERVAL
  done
}

# Check if the specified screen session is running
if screen -ls | grep -q "$SCREEN_SESSION"; then
  echo "Monitoring directory size in $DIRECTORY while $SCREEN_SESSION is running..."
else
  echo "$SCREEN_SESSION is not running."
  exit 1
fi

# Run the directory size calculation function in the background
calculate_directory_size &

# Script execution completes when the directory size calculation process exits
