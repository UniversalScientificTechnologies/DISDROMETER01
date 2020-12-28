#!/bin/sh
ntp-wait -v

ulimit -c unlimited

station='JAPAN0'

cd signal-piping-tools


if ! pidof sdr-widget > /dev/null; then
	./sdr-widget -r 96000 | ./servestream -d -p 3701&
fi

today=`date '+%Y_%m_%d_%H%M%S%N'`;
mkdir "../data/$today/"
filename="../data/$today/$station.wav"
nc localhost 3701|sox -S -t f32 -c 2 -r 96000 - -t wav $filename silence 1 0.1 1% 1 5.0 5%: newfile : restart

