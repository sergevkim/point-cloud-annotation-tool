#!/bin/sh

NAME=$1
PORT=$2

docker container stop -t 0 $NAME

USER_NAME=$(basename $HOME)
echo "Run as user '$USER_NAME'"

HOST_PATH=$(readlink -f "$PWD/../../")
DOCKER_PATH="/root/$NAME"

cd $HOST_PATH

(docker container run \
    --rm \
    -dit \
    --dns 217.10.39.4 --dns 8.8.8.8 \
    --privileged \
    -e DISPLAY=$DISPLAY \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume="/datasets:/datasets" \
    --volume="/home/sergevkim:/home/sergevkim" \
    --expose $PORT \
    --runtime=nvidia \
    -p $PORT:$PORT \
    -h $NAME \
    --name $NAME \
    $NAME
) || true

docker container exec -it $NAME bash
#docker container exec -it $NAME bash -c "
#    sudo cp /home/sergevkim/.bashrc /home/sergevkim/.vimrc ~/ && \
#    source ~/.bashrc && \
#    bash
#"

#--env="DISPLAY" \
#should i describe it here or in Dockerfile?
#--workdir="/home/$USER" \
#--volume="/home/$USER:/home/$USER" \
#-v $HOST_PATH:/$DOCKER_PATH \
#-v $HOME:/home/$USER_NAME \
