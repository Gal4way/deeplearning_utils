# cd /home/ubuntu/YX/code/openpose
# CUDA_VISIBLE_DEVICES=6 ./python --image_dir /home/ubuntu/YX/code/openpose/examples/media --write_images /home/ubuntu/YX/utils/gpu_save_posemap --write_images_format jpg --disable_blending --hand --display 0 &
# pid=$!
# sleep 15
# kill -SIGSTOP $pid
# cd -



#!/bin/bash

cd /home/ubuntu/YX/code/openpose

CUDA_VISIBLE_DEVICES=4,5 ./python --image_dir /home/ubuntu/YX/code/openpose/examples/media --write_images /home/ubuntu/YX/utils/gpu_save_posemap --write_images_format jpg --disable_blending --hand --display 0 &
pid=$!

while true; do
    over_threshold=true
    for gpu_id in 4 5; do
        mem_usage=$(nvidia-smi -i $gpu_id --query-gpu=memory.used --format=csv,noheader,nounits | awk '{print $1}')
        echo "GPU $gpu_id memory usage: $mem_usage MB"
        if (( mem_usage <= 32000 )); then
            over_threshold=false
            break
        fi
    done
    if $over_threshold; then
        kill -SIGSTOP $pid
        break
    fi
    sleep 1
done

cd -