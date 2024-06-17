#!/bin/bash
# $1: chain name / name of the folder to create in keys will be saved
# $2: number of keys to generate

mkdir -p keys/$1
seed=
echo $seed

echo "generating $2 node-keys for chain $1"
echo "_node_p2p_key_map:"

let "max_key_id=$2-1"
for i in `seq -w 0 $max_key_id`; do
  # generate node key
  subkey generate-node-key --file keys/$1/node-key-$i >/dev/null 2>&1
  subkey inspect-node-key --file keys/$1/node-key-$i > keys/$1/node-key-$i-id

  # output node keys config
  echo "  $1-node-$i:"
  echo "    node_parachain_p2p_public_key: $(cat keys/$1/node-key-$i-id)"
  echo "    node_parachain_p2p_private_key: $(cat keys/$1/node-key-$i)"
done

echo "_node_collator_aura_key_map:"
for i in `seq -w 0 $max_key_id`; do
  # generate collator aura key
  subkey generate --output-type json | awk -F'"' '/secretPhrase/{print $(NF-1)}' > keys/$1/collator-key-$i
  subkey inspect  keys/$1/collator-key-$i --output-type json | awk -F'"' '/ss58Address/{print $(NF-1)}' > keys/$1/collator-key-$i-address

  # output collator keys config
  echo "  $1-node-$i:"
  echo "    key_inject_parachain_aura_private_key: $(cat keys/$1/collator-key-$i)"
done

