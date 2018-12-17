FROM debian:9.6

RUN dpkg --add-architecture i386 && apt-get update && apt-get install wget gnupg2 -y
RUN wget -q "http://deb.playonlinux.com/public.gpg" -O- | apt-key add -
RUN wget 'http://deb.playonlinux.com/playonlinux_stretch.list' -O /etc/apt/sources.list.d/playonlinux.list && \
    apt-get update && \
    apt-get -y install \
    playonlinux \
    x11vnc \
    xvfb \
    x11-xserver-utils \
    netcat \
    gettext \
    procps \
    lsb-release \
    libc6:i386 \
    libncurses5:i386 \
    libstdc++6:i386 \
	libxml2:i386 \
	libxext6:i386 \
	libgl1-mesa-glx:i386 \
    libfreetype6:i386 \
    libldap-2.4-2:i386 \
    pulseaudio:i386 \
    libgstreamer-plugins-base1.0-0:i386 \
    xdotool \
    libjpeg62-turbo:i386 \
    libmpg123-0:i386 \
    python3 \
    python3-pip \
    python3-xlib \
    scrot

RUN pip3 install pyautogui

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/poe && \
    echo "poe:x:${uid}:${gid}:poe,,,:/home/poe:/bin/bash" >> /etc/passwd && \
    echo "poe:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/poe && \
    usermod -a -G video poe && \
    touch /home/poe/.Xauthority

USER poe
ENV HOME /home/poe
ENV USER poe
RUN mkdir /home/poe/setup /home/poe/launcher /home/poe/game

COPY setup /home/poe/setup
RUN /home/poe/setup/install-poe.sh

COPY launcher/ /home/poe/launcher
RUN /home/poe/launcher/patch-poe.sh

COPY game/ /home/poe/game

ENV WINEPREFIX /home/poe/.PlayOnLinux/wineprefix/pathofexile/

WORKDIR /home/poe

CMD ["/home/poe/game/play.sh"]


# RUN dpkg --add-architecture i386
# RUN apt-get install -y software-properties-common && add-apt-repository -y ppa:ubuntu-wine/ppa
# RUN apt-get update -y

#Install Wine to get rid of a few notification in playonlinux
# RUN apt-get install -qy wine1.7 winetricks wget libcanberra-gtk-module gettext
# gettext libgl1-mesa-dri:i386 libgl1-mesa-glx:i386 libfreetype6:i386 libcanberra-gtk-module

#Install playonlinux (instructions on site)
# RUN wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -
# RUN wget http://deb.playonlinux.com/playonlinux_trusty.list -O /etc/apt/sources.list.d/playonlinux.list
# RUN apt-get update -y
# RUN apt-get install -y playonlinux

#Change encoding for correct language select screens in playonlinux
# RUN sed -i 's/encoding = \"ascii\"/encoding = \"utf-8\"/g' /usr/lib/python2.7/site.py

#Cleanup
# RUN apt-get autoremove &&\
    # apt-get clean &&\
    # rm -rf /tmp/*

# Create a user to run as
# RUN export uid=1000 gid=1000 && \
    # mkdir -p /home/poe && \
    # echo "poe:x:${uid}:${gid}:poe,,,:/home/poe:/bin/bash" >> /etc/passwd && \
    # echo "poe:x:${uid}:" >> /etc/group && \
    # echo "poe ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/poe && \
    # chmod 0440 /etc/sudoers.d/poe && \
    # chown ${uid}:${gid} -R /home/poe &&\
    # usermod -a -G video poe
#
# #Use created user
# USER poe
# ENV HOME /home/poe
# ENV USER poe
#
# CMD playonlinux


