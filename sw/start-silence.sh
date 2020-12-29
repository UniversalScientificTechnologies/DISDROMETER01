#!/bin/bash
ntp-wait -v

ulimit -c unlimited
trap "echo Exited!; exit;" SIGINT SIGTERM

station='JAPAN0'

cd signal-piping-tools

if ! pidof sdr-widget > /dev/null; then
	./sdr-widget -r 96000 | ./servestream -d -p 3701&
fi

while true; do
    directory="../data" 
	true |nc localhost 3701|sox -S -t f32 -c 2 -r 96000 - -t wav $directory/precipitation.wav silence 1 0.1 2% 1 5.0 5%; time=`date '+%Y_%m_%d_%H%M%S%N'`; mv $directory/precipitation.wav $directory/$station-$time.wav 
done
