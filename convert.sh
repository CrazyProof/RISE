#!/usr/bin/env bash

cd /path/to/RISE/policy_and_value/policy_offline_and_value

python examples/aloha_real/convert_to_lerobot.py \
  --data-dir /mnt/data/RISE/data/aloha_mobile \
  --repo-ids aloha_mobile_fail \
  --prompt "Zip up the bag." \
  --save-dir /mnt/data/RISE/data/rollout \
  --save-repoid rollout_fail