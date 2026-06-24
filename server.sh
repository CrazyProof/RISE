#!/usr/bin/env bash
set -e

cd policy_and_value/policy_offline_and_value

CUDA_VISIBLE_DEVICES=0 python scripts/serve_policy.py \
  --port 8000 \
  --default-prompt "Zip up the bag." \
  policy:checkpoint \
  --policy.config Pi05_style_training \
  --policy.dir "$PWD/checkpoints/Pi05_style_training/Pi05_style_training_bag_all/30000"