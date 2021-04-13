# Build this by: docker build -t god .

#FROM tensorflow/tensorflow:latest-gpu
FROM kerberos/yolo34py-gpu

### Install Web Requests
#RUN apt-get update && apt-get install -y --no-install-recommends \
#		ca-certificates \
#		curl \
#		wget \
#	&& rm -rf /var/lib/apt/lists/*
#
#
### Install SCM support
#RUN apt-get update && apt-get install -y --no-install-recommends \
#		git \
#		openssh-client \
#		procps \
#	&& rm -rf /var/lib/apt/lists/*
#
### Install python3.5
#RUN add-apt-repository ppa:deadsnakes/ppa && \
#    apt-get update && \
#    apt-get install -y python3.5

# Set up application
#COPY ./requirements.txt /requirements.txt
ADD . /app/
RUN pip3 install gdown && \
    gdown -O /app/rsd-god.zip --id 1ttvSta0BRxW7tTV_st89vSb_obHVre34
RUN apt-get update && apt-get install -y --no-install-recommends unzip && \
    unzip /app/rsd-god.zip -d /app/rsd-god
#RUN cd /YOLO3-4-Py/src/ && python3 setup.py build_ext
#RUN export GPU=1 && export OPENCV=1 && pip3 install /YOLO3-4-Py/src/
#RUN wget -O /app/yolov3.weights https://pjreddie.com/media/files/yolov3.weights
RUN wget -O /app/backend.h5 https://s3-ap-southeast-1.amazonaws.com/deeplearning-mat/backend.h5
CMD /bin/bash
RUN echo "Now run with: docker run --gpus 2 -it --rm -u $(id -u):$(id -g) -w /app god"


