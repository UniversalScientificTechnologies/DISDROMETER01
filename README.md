# DISTROMETER01
Mobile piezoelectric [distrometer](https://en.wikipedia.org/wiki/Disdrometer) used to distinguishing between rain, graupel, and hail during scientific thunderstorm observation.

The signal digitalization is based on high-precision [sdr-widget](https://wiki.mlab.cz/doku.php?id=cs:sdr-widget) technology, which allows sophisticated signal processing.

![Piezoelectric distrometer mounted on a car platform](./doc/img/DISTROMETER01_mount.jpg)

![Distrometer sensing element](./doc/img/DISTROMETER01_internals.jpg)

Distrometer sensor is mounted in the standard TK PS 99-6-o 110 403 01 mounting box.

![Internal electronic of distrometer device ](./doc/img/DISTROMETER01_electronics.jpg)


### Usage

    sudo apt-get install sox


The directory sw contains a submodule with required dependency `signal-piping-tools`, which needs to be build prior start of distrometer recording script. 

    ./start.sh 

### Troubleshooting

#### Unable to connect to proper PID and VID device 

The USB device with ID `fffe:0007`  needs to be accesible by user using the scripts. 

    $ lsusb
    Bus 001 Device 004: ID 1546:01a6 U-Blox AG 
    Bus 001 Device 003: ID fffe:0007 
  
 There is valid sdr-widget device on bus 001 and port number 003. Listing of devices on that bus shows it has correct acces rights crw-rw-rw- therefore is available for all users for read and write.  
  
    $ ls -la /dev/bus/usb/001/
    total 0
    drwxr-xr-x 2 root root    120 Jan  1  1970 .
    drwxr-xr-x 4 root root     80 Jan  1  1970 ..
    crw-rw-r-- 1 root root 189, 0 Feb 11  2016 001
    crw-rw-r-- 1 root root 189, 1 Feb 11  2016 002
    crw-rw-rw- 1 root root 189, 2 Dec 28 09:53 003
    crw-rw-r-- 1 root root 189, 3 Feb 11  2016 004

    


