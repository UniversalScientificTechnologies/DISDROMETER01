# DISTROMETER01

Mobile piezoelectric [distrometer](https://en.wikipedia.org/wiki/Disdrometer) used to distinguishing between rain, graupel, and hail during scientific thunderstorm observation.

The signal digitalization is based on high-precision [sdr-widget](https://wiki.mlab.cz/doku.php?id=cs:sdr-widget) technology, which allows sophisticated signal processing.

![Piezoelectric distrometer mounted on a car platform](./doc/img/DISTROMETER01_mount.jpg)

![Distrometer sensing element](./doc/img/DISTROMETER01_internals.jpg)

Distrometer sensor is mounted in the standard TK PS 99-6-o 110 403 01 mounting box.

![Internal electronic of distrometer device ](./doc/img/DISTROMETER01_electronics.jpg)


### Prerequisites

The DISTROMETER01 device uses hpsdr protocol of sdr-widget. Therefore the [signal-piping-tools](https://github.com/MLAB-project/signal-piping-tools), are needed to read data from the sensor. The signal-piping-tools repository is included as submodule in this distrometer repository. Therefore it could be dowloaded by following commands from this repository.

    git submodule init
    git submodule update

After that the signal-piping-tools sources should be downloaded in "sw/signal-piping-tools"

    cd sw/signal-piping-tools

Then proceed according to README.md in that directory.


### Usage

    sudo apt-get install sox


The directory sw contains a submodule with required dependency "signal-piping-tools", which needs to be build prior start of distrometer recording script.

    ./start.sh
