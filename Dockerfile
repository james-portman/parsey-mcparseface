FROM ubuntu:15.10

RUN apt-get update
RUN apt-get -y install apt-utils python python-pip wget bash-completion git python-dev
RUN apt-get -y install openjdk-8-jdk pkg-config zip g++ zlib1g-dev unzip

# bazel
RUN wget https://github.com/bazelbuild/bazel/releases/download/0.2.2/bazel_0.2.2-linux-x86_64.deb
RUN dpkg -i bazel_0.2.2-linux-x86_64.deb

# swig
RUN apt-get -y install swig

# protocol buffers
# RUN pip freeze | grep protobuf1
RUN pip install -U protobuf==3.0.0b2

# asciitree
RUN pip install asciitree

RUN git clone --recursive https://github.com/tensorflow/models.git

RUN pip install numpy

RUN update-ca-certificates -f

RUN cd models/syntaxnet/tensorflow; ./configure; cd ..; bazel test syntaxnet/... util/utf8/...
RUN cd models/syntaxnet; echo 'Bob brought the pizza to Alice.' | syntaxnet/demo.sh
#RUN echo "README is at https://github.com/tensorflow/models/tree/master/syntaxnet"
