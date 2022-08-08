# Use last alpine version
FROM ubuntu:latest

# Installation of basic packages
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" TZ="Europe/Paris" apt-get install -qq -y sudo \
    git \
    vim \
    android-tools-adb \
    adb \
    openjdk-8-jdk \
    wget \
    python3.10 \
    python3-pip \
    unzip \
    python3-dev \
    python3-venv \
    build-essential \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg8-dev \
    zlib1g-dev \
    wkhtmltopdf
RUN apt-get autoclean

# Set sudo user
RUN useradd -m android && echo "android:android" | chpasswd && adduser android sudo
USER android

# Creation of the workdir
WORKDIR /home/android

# Set java environment
ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV PATH="$PATH:JAVA_HOME/tools/bin"

# Installation of jadx
RUN git clone https://github.com/skylot/jadx.git
WORKDIR jadx
RUN ./gradlew dist
WORKDIR /home/android

# Installation of apktool
RUN java -version
RUN wget -q https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool
RUN wget -q https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.6.1.jar -O apktool.jar
USER root
RUN mv apktool apktool.jar /usr/local/bin
RUN chmod +x /usr/local/bin/apktool /usr/local/bin/apktool.jar
USER android

# Installation of FireBase Scanner
RUN git clone https://github.com/shivsahni/FireBaseScanner

# Installation of frida
RUN pip install frida-tools

# Installation of dex2jar
RUN git clone https://github.com/pxb1988/dex2jar.git
WORKDIR ./dex2jar
RUN ./gradlew distZip
WORKDIR ./dex-tools/build/distributions
RUN unzip dex-tools-2.2-SNAPSHOT.zip
WORKDIR /home/android

# Installation of quark
RUN pip install --user qark

# Installation of mobsf
RUN git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF.git
WORKDIR ./Mobile-Security-Framework-MobSF
RUN ./setup.sh
WORKDIR /home/android

# Installation of MARA framework
RUN git clone https://github.com/xtiankisutsa/MARA_Framework.git

# Define the entry point
ENTRYPOINT /bin/bash