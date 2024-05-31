# Ansible Parachain Deployment Quickstart

## Setup

* Install ansible requirements
```
ansible-galaxy collection install -f -r requirements.yml
```
* Edit your inventory of hosts in `inventory.yaml`

* Replace `templates/chainspec.raw.json` by your own parachain chainspec.

* Edit the following configuration in `group_vars/`:

- `all.yml`:
```
node_user: my-parachain
node_parachain_chain: my-parachain
node_binary: https://github.com/paritytech/polkadot-sdk/releases/latest/download/polkadot-parachain
node_parachain_chainspec: chainspec.raw.json
_node_p2p_key_map: # Add your nodes network keys
```
  - `collators.yml`:
```
node_app_name: my-parachain-collator
_node_collator_aura_key_map: # Add your secret seeds instead of `//Alice` and `//Bob`.
```
- `rpcs.yaml`
```
node_app_name: my-parachain-rpc
# TODO add nginx+letsencrypt config
```
## Apply the playbook

To execute the playbook, install ansible (https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) and execute:

    ansible-playbook my-parachain-playbook.yml -i inventory.yaml

## Special

To reset the parachain database (in case you generated a new raw chainspec with different head state)

    ansible-playbook my-parachain-playbook.yml -i inventory.yaml -e  "node_parachain_database_wipe=true"


To reset the relay chain database (due to sync issues):

    ansible-playbook my-parachain-playbook.yml -i inventory.yaml -e  "node_database_wipe=true"
