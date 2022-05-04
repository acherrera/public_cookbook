# Satellite Imagery Wallpaper

Download the latest high resolution satellite imagery

# Running Consistently

Using crontab to run this every 30 minutes, use this: 

```
*/30 * * * * /usr/bin/python3.6 /home/nmk7ii6/Repos/personal/public_cookbook/scripts/satellite_wallpape/downloader.py > /tmp/listener.log 2>&1 
```
