################################################
##  DOCKER CONTAINER TO BUILD AOSP/LINEAGE OS ##
################################################

FROM ubuntu:14.04
MAINTAINER Corey Jameson <coreyaj1986@gmail.com>

# Update apt repos and add 32bit arch
RUN sed -i 's/main$/main universe/' /etc/apt/sources.list
RUN dpkg --add-architecture i386
RUN apt-get -qq update && apt-get -qqy dist-upgrade



# Install essential packages

RUN apt-get -y install curl git mc rsync screen tig

# The master branch of Android in the Android Open Source Project (AOSP)

# requires Java 8. On Ubuntu, use OpenJDK.

# RUN apt-get -y install openjdk-8-jdk
RUN apt-get -y install openjdk-7-jdk

RUN update-alternatives --config java
RUN update-alternatives --config javac

# Installing required packages (Ubuntu 14.04)

RUN apt-get -y install git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils schedtool xsltproc unzip python-networkx

# Installing additional packages (required for build_android_udooneo)

RUN apt-get -y install bc lzop u-boot-tools
RUN apt-get -y install apt-file
RUN apt-file update


RUN curl http://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
RUN chmod a+x /usr/local/bin/repo



# Create user "

RUN id builder 2>/dev/null || useradd --uid 1000 --create-home --shell /bin/bash builder



# Create a non-root user that will perform the actual build

RUN id aospbuild 2>/dev/null || useradd --uid 30000 --create-home --shell /bin/bash aospbuild

RUN echo "aospbuild ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
USER aospbuild
WORKDIR /home/aospbuild
CMD "/bin/bash"
