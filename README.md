# Parachain Deployment Quickstart

This repository contains configurations to deploy a test network as described in the [Parachain Deployment Guide](https://paritytech.github.io/devops-guide/guides/parachain_deployment.html)

The `chainspec` folder contains a sample chainspec based on [paritytech/polkadot-sdk-parachain-template](https://github.com/paritytech/polkadot-sdk-parachain-template) default keys (Alice and Bob collator keys and hardcoded unsecure node keys).

## Deployment method

* [Ansible](./ansible)
* [Kubernetes](./kubernetes)


## Generate keys

You can use this bash script to generate several keys in one go.

    ./generate-keys.sh my-parachain 3
