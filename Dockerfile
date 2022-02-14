FROM jeanblanchard/alpine-glibc
MAINTAINER Laird Nelson <ljnelson@gmail.com>
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/opt/calibre/lib
ENV PATH $PATH:/opt/calibre/bin
ENV CALIBRE_INSTALLER_SOURCE_CODE_URL https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
    apk update && \
    apk add --no-cache --upgrade \
    bash \
    ca-certificates \
    gcc \
    mesa-gl \
    python3 \
    qt5-qtbase-x11 \
    wget \
    xdg-utils \
    xz && \
    wget -O- ${CALIBRE_INSTALLER_SOURCE_CODE_URL} | python3 -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main(install_dir='/opt', isolated=True)" && \
    rm -rf /tmp/calibre-installer-cache
    
