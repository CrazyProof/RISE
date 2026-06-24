#!/usr/bin/env bash

set -e

source /opt/ros/noetic/setup.bash
source ~/cobot_magic/Piper_ros_private-ros-noetic/devel/setup.bash

# 修复 Conda libffi 与系统 ROS 的冲突
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libffi.so.7

python deploy/piper_deploy.py \
  --host 127.0.0.1 \
  --port 8000 \
  --ctrl_type joint \
  --use_temporal_smoothing \
  --chunk_size 50 \
  --lang_embeddings "Zip up the bag."