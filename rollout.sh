#!/usr/bin/env bash

set -e

source /opt/ros/noetic/setup.bash
source ~/cobot_magic/Piper_ros_private-ros-noetic/devel/setup.bash

# 修复 Conda libffi 与系统 ROS 的冲突
export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libffi.so.7

python -m deploy.data_collection.collect_inference_data \
  --use_temporal_smoothing \
  --ctrl_type joint \
  --export_video \
  --chunk_size 50 \
  --host 127.0.0.1 \
  --port 8000 \
  --dataset_dir /media/agilex/"TOSHIBA EXT"/RISE/policy_and_value/policy_offline_and_value/data