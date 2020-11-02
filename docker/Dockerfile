FROM nvidia/opengl:1.2-glvnd-runtime-ubuntu16.04

MAINTAINER Serge sergevkim@gmail.com

# Install prerequested
RUN apt-get -y update && apt-get -y install \
    apt-transport-https \
    bash-completion \
    build-essential \
    firefox \
    git \
    htop \
    sudo \
    software-properties-common \
    tmux \
    tree \
    unzip \
    vim \
    wget \
    xauth \
    libboost-all-dev \
    libssl-dev \
    libgl1-mesa-dev \
    libice6 \
    libsm6 \
    libsndfile1 \
    libxt-dev \
    libxt6 \
    libxrender1 \
    libfontconfig1 \
    libcups2 \
    libcanberra-gtk*

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer

ENV HOME /home/developer

#LLVM
RUN sudo wget https://apt.llvm.org/llvm.sh && \
    sudo chmod +x llvm.sh && \
    sudo ./llvm.sh 10

#gcc-7 g++-7
RUN sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
    sudo apt-get update && \
    sudo apt-get install g++-7 -y && \
    cd /usr/bin && \
    sudo rm gcc && \
    sudo rm g++ && \
    sudo ln -s gcc-7 gcc && \
    sudo ln -s g++-7 g++ && \
    cd -

#CMake
RUN sudo wget https://github.com/Kitware/CMake/releases/download/v3.18.4/cmake-3.18.4.tar.gz && \
    sudo tar -xvf cmake-3.18.4.tar.gz && \
    cd cmake-3.18.4 && \
    sudo ./bootstrap && \
    sudo make -j4 && \
    sudo make -j4 install && \
    cd ..

#QT5
RUN sudo git clone https://code.qt.io/qt/qt5.git qt5
RUN export CMAKE_PREFIX_PATH="/usr/local/Qt-5.15.1/lib/cmake/Qt5"
RUN cd qt5 && \
    sudo git checkout 5.15.1 && \
    sudo perl init-repository && \
    cd .. && \
    sudo mkdir qt5-build && \
    cd qt5-build && \
    sudo ../qt5/configure -opensource -nomake examples -nomake tests && \
    sudo make -j4 && \
    sudo make -j4 install && \
    cd ../..
ENV CMAKE_PREFIX_PATH=/usr/local/Qt-5.15.1/lib/cmake/Qt5
ENV Qt5_DIR=/usr/local/Qt-5.15.1/lib/cmake/Qt5
RUN sudo apt-get -y update && sudo apt-get -y install \
    qtbase5-dev \
    qtdeclarative5-dev \
    libqt5x11extras5-dev \
    qttools5-dev

#VTK
RUN sudo wget https://github.com/Kitware/VTK/archive/v8.1.1.tar.gz && \
    sudo tar -xvf v8.1.1.tar.gz && \
    cd VTK-8.1.1 && \
    sudo mkdir build && \
    cd build && \
    sudo cmake -DVTK_QT_VERSION:STRING=5 \
               -DQT_QMAKE_EXECUTABLE:PATH=/usr/local/Qt-5.15.1/bin/qmake \
               -DVTK_Group_Qt:BOOL=ON \
               -DCMAKE_PREFIX_PATH:PATH=/usr/local/bin/cmake \
               -DBUILD_SHARED_LIBS:BOOL=ON \
               .. && \
    sudo make -j4 && \
    sudo make -j4 install && \
    cd ../..

#Eigen
RUN sudo wget https://gitlab.com/libeigen/eigen/-/archive/3.3.7/eigen-3.3.7.tar.gz && \
    sudo tar -xvf eigen-3.3.7.tar.gz && \
    cd eigen-3.3.7 && \
    sudo mkdir build && \
    cd build && \
    sudo cmake .. && \
    sudo make -j4 && \
    sudo make -j4 install && \
    cd ../..

#FLANN
RUN sudo wget https://github.com/mariusmuja/flann/archive/1.8.5.tar.gz && \
    sudo tar -xvf 1.8.5.tar.gz flann-1.8.5 && \
    cd flann-1.8.5 && \
    sudo touch src/cpp/empty.cpp && \
    sudo sed -i 's/add_library(flann_cpp SHARED "")/add_library(flann_cpp SHARED empty.cpp)/g' src/cpp/CMakeLists.txt && \
    sudo sed -i 's/add_library(flann SHARED "")/add_library(flann SHARED empty.cpp)/g' src/cpp/CMakeLists.txt && \
    sudo mkdir build && \
    cd build && \
    sudo cmake .. && \
    sudo make -j4 && \
    sudo make -j4 install && \
    cd ../..

#PCL
RUN sudo wget https://github.com/PointCloudLibrary/pcl/archive/pcl-1.8.1.tar.gz && \
    sudo tar -xvf pcl-1.8.1.tar.gz && \
    cd pcl-pcl-1.8.1 && \
    sudo mkdir build && \
    cd build && \
    sudo cmake .. -DCMAKE_BUILD_TYPE=Release && \
    sudo make -j4 && \
    sudo make -j4 install && \
    cd ../..

RUN ls

#PCAT
RUN cd ~/ && \
    sudo git clone https://github.com/sergevkim/point-cloud-annotation-tool.git pcat && \
    cd pcat && \
    sudo mkdir build && \
    cd build && \
    sudo cmake .. && \
    sudo make -j4 && \
    cd ../.. && \
    sudo cp /pcl-pcl-1.8.1/test/bun4.pcd .

