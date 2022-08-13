#!/bin/sh
#ntp-wait -v

ulimit -c unlimited

echo "Waiting for time sync.. "
chronyc -h 192.168.1.2,::1 waitsync 0 0.1 0.0 1
echo "Time synchronized"

#TODO set variable only if not exist 
#station='UNKNOWN'

cd /home/kaklik/repos/DISTROMETER01/sw

cd signal-piping-tools

rm -rf 3731_taps
./fir_taps -n 512 -r 96000 -c 1000 -w hanning > 3731_taps

if ! pidof sdr-widget > /dev/null; then
	{ nice -n -4 ./sdr-widget -r 96000 | nice -n -3 buffer -s 128k -m 16m & } | ./servestream -d -p 3701
fi

if ! pidof ./servecmd > /dev/null; then
    ./servecmd -d -p 3731 'nc localhost 3701 | buffer -s 64k -m 2m | ./x_fir_dec -b 128 96000 26500 48 3731_taps'
fi

echo "Starting recording of wav files."

while true; do
    today=`date '+%Y%m%d_%H%M%S%N'`;
    filename="/data/distrometer/$station-$today.wav"
    echo "Recording "$filename
    true | nc localhost 3701 | sox -t f32 -c 2 -r 96000 - -t wav $filename trim 0 300
done
