# Android_reverse
This is docker with lots of tools for android reverse application.  

## Integrated tools

* Vim
* Frida
* adb
* python3.10
* python2.7
* opendjdk-8
* git
* jadx
* apktool
* Firebase Scanner
* dex2jar
* quark
* MobSF
* MARA framework

## Installation

You can follow these steps:  

```
git clone https://github.com/Radion94200/Android_reverse.git
cd android_reverse
docker build --tag androidrev .
```

## Use docker reverseapp

```
docker run --rm -it androidrev
```

## Next features

* Add graphical interface for MobSF
* Decrease size of the docker image
* Add PIDCAT