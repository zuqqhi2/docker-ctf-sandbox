FROM 32bit/ubuntu:16.04
MAINTAINER Hidetomo SUZUKI <zuqqhi2@gmail.com>
LABEL description="This is for CTF (Capture The Flag) env."

#=== Install base softwares by apt ======
RUN apt-get update && apt-get install -y \
  vim \
  wget \
  strace \
  ltrace \
  ghex \
  binutils \
  build-essential \
  gcc \
  g++ \
  git \
  unzip \
  libgtk2.0-0 \
  libxxf86vm1 \
  libsm6 \
  lib32stdc++6 \
  socat \
  python3 \
  python3-pip \
  python2.7 \
  python-pip \
  python-dev \
  libssl-dev \
  libffi-dev \
  gcc-multilib \
  gdb


#=== Install without apt =====
WORKDIR /root

# radare2
RUN git clone https://github.com/radare/radare2 && \
  cd radare2 && \
  sys/install.sh

# dex2jar
RUN wget http://sourceforge.net/projects/dex2jar/files/dex2jar-2.0.zip && \
  unzip dex2jar-2.0.zip && \
  cd dex2jar-2.0 && \
  chmod u+x ./*.sh && \
  export PATH=$PATH:/root/dex2jar-2.0/

# jd-gui
RUN wget http://jd.benow.ca/jd-gui/downloads/jd-gui-0.3.5.linux.i686.tar.gz && \
  tar zxvf jd-gui-0.3.5.linux.i686.tar.gz && \
  mkdir tool && \
  mv jd-gui tool && \
  export PATH=$PATH:/root/tool

# checksec.sh
RUN wget http://github.com/slimm609/checksec.sh/archive/1.6.tar.gz && \
  tar zxvf 1.6.tar.gz && \
  cp checksec.sh-1.6/checksec /root/tool/checksec.sh

# peda
RUN git clone https://github.com/zachriggle/peda && \
  echo "source /root/peda/peda.py" >> /root/.gdbinit && \
  export PATH=/root/tool:$PATH && \ 
  cd /root/tool && \
  wget https://github.com/downloads/0vercl0k/rp/rp-lin-x64 -O /root/tool/rp

# pwntools
RUN pip install --upgrade pip pwntools

# Other
RUN pip3 install --upgrade pip`
