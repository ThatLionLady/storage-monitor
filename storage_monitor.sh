#!/bin/bash

echo ""
echo "ThatLionLady's storage-monitor: Monitor directory storage for the duration of a screen session."
echo "It is recommended to run this script in screen (https://www.gnu.org/software/screen/)."
echo ""

if [ $# -eq 0 ]; then
    echo "Usage: storage_monitor.sh DIRECTORY INTERVAL SCREEN_SESSION [LOG_FILE]"
    echo ""
    echo "DIRECTORY       path to monitored directory (i.e. /data/)"
    echo "INTERVAL        interval in seconds (i.e. 300 for 5 minutes)"
    echo "SCREEN_SESSION  screen session sockname (i.e. \run1\)"
    echo "[LOG_FILE]      optional: output log file name (default: storage-monitor.log)"
    echo ""
    echo "Go to https://github.com/ThatLionLady/storage-monitor/ for more details"
    exit 1
fi

# Define the directory you want to monitor
DIRECTORY=${1}

# Define the interval in seconds (5 minutes = 300 seconds)
INTERVAL=${2}

# Define the screen session sockname where you're running
SCREEN_SESSION=${3}

# Define the log file to store the directory sizes
LOG_FILE=${4}

# Check arguments

if [ ! -d "${DIRECTORY}" ]; then
    echo "Error: The specified directory '${DIRECTORY}' does not exist."
fi

if [ -z "${INTERVAL}" ]; then
    echo "Error: INTERVAL must be specified."
fi

if ! [[ "$INTERVAL" =~ ^[0-9]+$ ]]; then
    echo "Error: Interval must be a positive integer."
fi

if [ -z "${SCREEN_SESSION}" ]; then
    echo "Error: A screen session sockname must be specified."
    exit 1
fi

if [ -z "${LOG_FILE}" ]; then
    echo "LOG_FILE was not specified. LOG_FILE will be written to the current directory as storage-monitor.log"
    LOG_FILE=storage-monitor.log
fi

# Function to calculate and log directory size
calculate_directory_size() {
  while true; do
    # Check if the specified screen session is running
    if ! screen -list | grep -q "${SCREEN_SESSION}"; then
      echo "${SCREEN_SESSION} has ended. Exiting..."
      exit 0
    fi

    # Use 'du' to calculate the size of the directory in KB
    DIR_SIZE=$(du -sBK "${DIRECTORY}" | awk '{print $1}')
    
    # Get the current date/time
    CURRENT_DATETIME=$(date +%F\ %T)
    
    # Log the current date/time and directory size to the log file
    echo "${CURRENT_DATETIME}: Directory size in ${DIRECTORY} is ${DIR_SIZE}" >> "${LOG_FILE}"
    
    # Sleep for the specified interval
    sleep ${INTERVAL}
  done
}

# Check if the specified screen session is running
if screen -list | grep -q "${SCREEN_SESSION}"; then
  echo "Monitoring total directory size in ${DIRECTORY} while \"${SCREEN_SESSION}\" is running..."
  # Run the directory size calculation function in the background
  calculate_directory_size &
else
  echo "\"${SCREEN_SESSION}\" is not running."
  exit 1
fi

# Wait for the background process to complete
wait
