# storage-monitor

This script will monitor storage in a given directory for the duration of a screen session.

# Usage

Download script:

```sh
wget https://github.com/ThatLionLady/storage-monitor/blob/main/storage-monitor.sh
```

Make script executable:

```sh
chmod +x storage-monitor.sh
```

Run script after starting a screen session:

```sh
screen
storage-monitor.sh DIRECTORY INTERVAL SCREEN_SESSION [LOG_FILE]
#Ctrl-A
#Ctrl-D
```
|||
|:-|:-|
|DIRECTORY|path to monitored directory|
|INTERVAL|interval in seconds|
|SCREEN_SESSION|screen session sockname|
|[LOG_FILE]|optional: output log file name<br>(default: storage-monitor.log)  
<br>

>***Note:*** *If you plan on closing your terminal during the screen session, the script needs to be run via a second screen. If you plan to keep your terminal open for the duration of the screen session, then it can just be run in the background as follows:*

```sh
storage-monitor.sh /1/ 2 "3" &
```

# Example

Monitor */data/* directory every 5 minutes after starting `screen -S run1 -dm command`.

```sh
screen -S monitor -dm storage-monitor.sh /data/ 300 "run1"
```

# Output

A file named *storage-monitor.log* will be created in the current directory where each line says:

`${CURRENT_DATETIME}: Directory size in ${DIRECTORY} is ${DIR_SIZE}"`

For example:

```txt
2023-09-06 21:15:35: Directory size in /data/ is 1343K
2023-09-06 21:20:35: Directory size in /data/ is 1347K
2023-09-06 21:25:36: Directory size in /data/ is 1351K
2023-09-06 21:30:36: Directory size in /data/ is 1367K
2023-09-06 21:35:36: Directory size in /data/ is 1412K
```
