#!/bin/sh
ntp-wait -v

ulimit -c unlimited

station='CAR0'

cd signal-piping-tools

rm -rf 3731_taps
./fir_taps -n 512 -r 96000 -c 1000 -w hanning > 3731_taps

if ! pidof sdr-widget > /dev/null; then
	{ ./sdr-widget -r 96000 | buffer & } | ./servestream -d -p 3701
fi

if ! pidof ./servecmd > /dev/null; then
    ./servecmd -d -p 3731 'nc localhost 3701 | buffer -s 64k -m 2m | ./x_fir_dec -b 128 96000 26500 48 3731_taps'
fi

while true; do
    today=`date '+%Y_%m_%d_%H%M%S%N'`;
    filename="/data/distrometer/$station-$today.wav"
    nc localhost 3701 | sox -t f32 -c 2 -r 96000 - $filename trim 0 60
done
