#/bin/bash
export MY_CONTAINER="fanwu103-atom-mimo-pd"
num=`docker ps -a|grep "$MY_CONTAINER"|wc -l`
echo $num
echo $MY_CONTAINER
if [ 0 -eq $num ];then
docker run -e  DISPLAY=$DISPLAY --net=host --pid=host --ipc=host \
        --shm-size 64g \
        --privileged \
        -it \
        -v /dev/infiniband:/dev/infiniband \
        -v /tools/:/tools/ \
        -v /mnt/:/mnt/ \
        -v /data/:/data/ \
        -v /it-share/:/it-share/ \
        -v /home/:/home/ \
        --name $MY_CONTAINER  \
        rocm/atom-dev:vllm-v0.19.0-nightly_20260517-mooncake-dev-latest \
        /bin/bash
else
docker start $MY_CONTAINER
docker exec -ti $MY_CONTAINER /bin/bash
fi
