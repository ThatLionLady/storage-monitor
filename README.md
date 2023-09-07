# storage_monitor

This script will monitor storage in a given directory for the duration of a screen session.

# Usage

```sh
# download script
wget https://github.com/ThatLionLady/storage_monitor/blob/main/storage_monitor.sh

# make script executable
chmod +x storage_monitor.sh

# run script after starting a screen session
storage_monitor.sh 1 2 3 
```

1. /PATH/TO/DIRECTORY/
2. Interval in Seconds
3. `screen` session sockname in quotes

# Example

Monitor */data/* directory every 5 minutes after starting `screen -S run1 -dm command`.

```sh
storage_monitor.sh /data/ 300 "run1"
```

# Output

A file named *storage_monitor.log* will be created in the current directory where each line says:

`$current_datetime: Directory size in $DIRECTORY is $dir_size"`

For example:

```txt
2023-09-06 21:15:35: Directory size in /data/ is 1343K
2023-09-06 21:20:35: Directory size in /data/ is 1347K
2023-09-06 21:25:36: Directory size in /data/ is 1351K
2023-09-06 21:30:36: Directory size in /data/ is 1367K
2023-09-06 21:35:36: Directory size in /data/ is 1412K
```