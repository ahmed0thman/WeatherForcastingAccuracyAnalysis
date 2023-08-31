#! /bin/bash

today=$(date +%Y%m%d)
weather_report=raw_data_$today.txt
#touch $weather_report
city=Cairo
curl wttr.in/$city --output $weather_report
grep °C $weather_report > temps.txt
obs_tmp=$(cat -A  temps.txt | head -1 | tr -d '\- ' | cut -d '.' -f3 | grep -oE "m[0-9][0-9]*" | tr -d 'm')
echo observed temperature $obs_tmp °C
fc_tmp=$(cat -A  temps.txt | head -3 |tail -1 | tr -d '\- ' | cut -d '.' -f5 | grep -oE "m[0-9][0-9]*" | tr -d 'm')
echo tomorrow temperature  $fc_tmp °C
year=$(date -u +%y)
month=$(date -u +%m)
day=$(date -u +%d)
hour=$(date -u +%H)
echo -e $year"\t"$month"\t"$day"\t"$obs_tmp"\t"$fc_tmp >> rx_poc.log

