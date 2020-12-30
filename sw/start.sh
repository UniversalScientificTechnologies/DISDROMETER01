#!/bin/sh
ntp-wait -v

ulimit -c unlimited
trap "echo Exited!; exit;" SIGINT SIGTERM

station='JAPAN0'
directory="../data" 

cd signal-piping-tools

rm -rf 3731_taps
./fir_taps -n 512 -r 96000 -c 1000 -w hanning > 3731_taps

if ! pidof sdr-widget > /dev/null; then
	{ nice -n -4 ./sdr-widget -r 96000 | nice -n -3 buffer -s 128k -m 16m & } | ./servestream -d -p 3701
fi

if ! pidof ./servecmd > /dev/null; then
    ./servecmd -d -p 3731 'nc localhost 3701 | buffer -s 64k -m 2m | ./x_fir_dec -b 128 96000 26500 48 3731_taps'
fi

while true; do
	true |\
	nc localhost 3701|sox -S -t f32 -c 2 -r 96000 - -t wav $directory/precipitation.wav silence 1 0.1 2% 1 5.0 5%;\ 
	time=`date '+%Y_%m_%d_%H%M%S%N'`;\ 
	mv $directory/precipitation.wav $directory/$station-$time.wav 
done

