FROM centos:centos7
# Get updates
RUN yum update -y && yum install -y epel-release
# Install FFMpeg as per https://trac.ffmpeg.org/wiki/CompilationGuide/Centos
RUN yum install -y autoconf automake cmake freetype-devel gcc gcc-c++ git libtool make mercurial nasm pkgconfig zlib-devel
ENV HOME /root
RUN mkdir ${HOME}/ffmpeg_sources
# YASM
WORKDIR ${HOME}/ffmpeg_sources
RUN git clone --depth 1 http://github.com/yasm/yasm.git
WORKDIR ${HOME}/ffmpeg_sources/yasm
RUN autoreconf -fiv
RUN ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"
RUN make
RUN make install
RUN make distclean
ENV PATH ${HOME}/bin:$PATH
RUN echo $PATH
# libx264=
WORKDIR ${HOME}/ffmpeg_sources
RUN git clone --depth 1 git://git.videolan.org/x264.git
WORKDIR ${HOME}/ffmpeg_sources/x264
RUN PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static
RUN make
RUN make install
RUN make distclean
# libx265
WORKDIR ${HOME}/ffmpeg_sources
RUN hg clone https://bitbucket.org/multicoreware/x265
WORKDIR ${HOME}/ffmpeg_sources/x265/build/linux
RUN cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source
RUN make
RUN make install
# libfdk_aac ¶
WORKDIR ${HOME}/ffmpeg_sources
RUN git clone --depth 1 http://git.code.sf.net/p/opencore-amr/fdk-aac
WORKDIR ${HOME}/ffmpeg_sources/fdk-aac
RUN autoreconf -fiv
RUN ./configure --prefix="$HOME/ffmpeg_build" --disable-shared
RUN make
RUN make install
RUN make distclean
# libmp3lame
WORKDIR ${HOME}/ffmpeg_sources
RUN curl -L -O http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
RUN tar xzvf lame-3.99.5.tar.gz
WORKDIR ${HOME}/ffmpeg_sources/lame-3.99.5
RUN ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --disable-shared --enable-nasm
RUN make
RUN make install
RUN make distclean
# libopus
WORKDIR ${HOME}/ffmpeg_sources
RUN git clone http://git.opus-codec.org/opus.git
WORKDIR ${HOME}/ffmpeg_sources/opus
RUN autoreconf -fiv
RUN ./configure --prefix="$HOME/ffmpeg_build" --disable-shared
RUN make
RUN make install
RUN make distclean
# libogg
WORKDIR ${HOME}/ffmpeg_sources
RUN curl -O http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.gz
RUN tar xzvf libogg-1.3.2.tar.gz
WORKDIR ${HOME}/ffmpeg_sources/libogg-1.3.2
RUN ./configure --prefix="$HOME/ffmpeg_build" --disable-shared
RUN make
RUN make install
RUN make distclean
# libvorbis
WORKDIR ${HOME}/ffmpeg_sources
RUN curl -O http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.4.tar.gz
RUN tar xzvf libvorbis-1.3.4.tar.gz
WORKDIR ${HOME}/ffmpeg_sources/libvorbis-1.3.4
RUN LDFLAGS="-L$HOME/ffmeg_build/lib" CPPFLAGS="-I$HOME/ffmpeg_build/include" ./configure --prefix="$HOME/ffmpeg_build" --with-ogg="$HOME/ffmpeg_build" --disable-shared
RUN make
RUN make install
RUN make distclean
# libvpx
WORKDIR ${HOME}/ffmpeg_sources
RUN git clone --depth 1 http://chromium.googlesource.com/webm/libvpx.git
WORKDIR ${HOME}/ffmpeg_sources/libvpx
RUN ./configure --prefix="$HOME/ffmpeg_build" --disable-examples
RUN make
RUN make install
RUN make clean
# FFMpeg
WORKDIR ${HOME}/ffmpeg_sources
RUN git clone --depth 1 git://source.ffmpeg.org/ffmpeg
WORKDIR ${HOME}/ffmpeg_sources/ffmpeg
RUN PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" --bindir="$HOME/bin" --pkg-config-flags="--static" --enable-gpl --enable-nonfree --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libopus --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265
RUN make
RUN make install
RUN make distclean
RUN hash -r

###
# Install Dejavu
###
# Install the dependencies
RUN yum install -y numpy scipy python-matplotlib ffmpeg portaudio-devel python-pip gcc gcc-c++ libpng libpng-devel freetype freetype-devel git
RUN pip install --upgrade pip
RUN pip install PyAudio
RUN pip install pydub

# Now setup virtualenv
RUN pip install virtualenv
RUN virtualenv --system-site-packages env_with_system

# Install from PyPI
RUN source env_with_system/bin/activate
RUN pip install PyDejavu
RUN yum install -y mysql-devel
RUN pip install mysql-python

# Get Dejavu code
WORKDIR ${HOME}
RUN git clone https://github.com/worldveil/dejavu.git ./dejavu
WORKDIR ${HOME}/dejavu
ADD dejavu.cnf ./
ADD scripts/ ./scripts
ADD load_scripts.py ./
ADD dejavu.py ./
ADD stomp_listener.py ./
ADD check_files.sh ./

# Get the stomp client
RUN pip install stomp.py
CMD python stomp_listener.py
