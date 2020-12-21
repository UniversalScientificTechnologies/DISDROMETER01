#!/bin/bash

station='CAR1'

while true; do
    today=`date '+%Y_%m_%d_%H%M%S%N'`;
    filename="./$station-$today.wav"
    arecord -f S24_3LE -c 2 -r 96000 -D hw:2,0 -d 600 $filename
done
