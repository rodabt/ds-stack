# Data Science Stack
#
# docker run --rm -p 8888:8888 -v $(pwd):/data -it rodabt/ds-stack /bin/bash
#

FROM alpine:latest
MAINTAINER  Rodrigo Abt <rodrigo.abt@gmail.com>

RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN apk add --update --no-cache ca-certificates gcc g++ curl openblas-dev@community

RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

RUN apk update && apk add --no-cache bash bc git curl coreutils imagemagick findutils grep man \
		less parallel p7zip ncurses sudo libpng libpng-dev freetype freetype-dev \
		sed tar tree unrar unzip jq nano wget python3 python3-dev g++ && \
	wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://github.com/sgerrand/alpine-pkg-R/releases/download/3.3.1-r0/sgerrand.rsa.pub && \
	wget https://github.com/sgerrand/alpine-pkg-R/releases/download/3.3.1-r0/R-3.3.1-r0.apk && \
	apk add R-3.3.1-r0.apk && \
	rm R-3.3.1-r0.apk && \
  	python3 -m ensurepip && \
    	rm -r /usr/lib/python*/ensurepip && \
    	pip3 install --upgrade pip setuptools && \
    	pip3 install --no-cache-dir --disable-pip-version-check numpy==1.11.0 scipy==0.18.0 scikit-learn==0.18.1 && \    	
    	pip3 install --no-cache-dir --disable-pip-version-check pandas \
    		ipython \
    		matplotlib \
    		jupyter \
    		altair \
    		db.py \
    		pandasql \
    		argparse \
    		pandas-profiling \
		csvkit \
    		Flask && \
    	rm -r /root/.cache && \
    	echo "export PS1=\"\u@\h:\w$ \"" > ~/.bashrc && \
        echo "alias ls='ls --color'" >> ~/.bashrc

WORKDIR /data
