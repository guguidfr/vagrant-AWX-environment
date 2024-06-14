# ssh-keys for AWX access  

Create 2 files for ssh access to the minion nodes:  
- `vagrant_priv_key`: the private key
- `vagrant_ssh_key.pub`: the public key

The public key will be added automatically to the minion nodes.  
Use the private key in the AWX inventory for the minion nodes.