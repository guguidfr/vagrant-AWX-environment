# vagrant-AWX-environment
This project aims to help with automations development, creating a simple and volatile AWX environment with three machines to test your roles and playbooks.  
  
The AWX I used is `24.5.0`, but feel free to use whichever you want.
*The project **may** or **may not** work using a different AWX version.*

---
## Requirements
To deploy the project, you will need to install:
- Oracle Virtualbox.
- Hashicorp Vagrant.

Both of this applications are available for Linux and Windows.
*Remember to enable virtualization in your BIOS settings and OS.*

---
## The VMs
The Vagrantfile creates **4** virtual machines:
- `ansible_awx`: The main node of the virtual network and where AWX will be hosted.
- `minions`: Three nodes that will just *exist* for automation testing.  
  
The default network configuration for these VMs is defined as **private network**, and if you want to use the IPs I have stablished, in case of Linux, you might need to add to `/etc/vbox/networks.conf` the following line:
```ini
* 10.0.0.0/8 192.168.0.0/16
```  
Also, you can edit the IPs and network configuration to whatever suits you better.

Before executing `vagrant up` for the first time, remember to create the necessary ssh keys. You can find a `README` in `/provisioning/ssh_keys`. This is to get used to create ssh credentials in AWX, but you can comment the line `35` in the Vagrantfile to skip this.

Once you have completed the previous configurations, use `vagrant up` to create the VMs.

You'll encounter a message warning you about the AWX containers; this is just a reminder of how to proceed after the first time you deploy the AWX.

---
## Deploying AWX inside the VM
To make things simple, once the machines are ready, ssh into the AWX node using `vagrant ssh ansible_awx`, and go to `ansible_resources` in your home directory.
Here you will find the following scripts:
- `awx_1st_boot_up.sh`: Execute this script ***only the first time you bring up the VMs***. At the end of the script, you will be asked to create an admin user for AWX; feel free to use any username and password, but remember that vagrant is used only for development and private environments, son even if you choose a *really* safe password, your VM will be pretty accessible from within you network.
- `awx_restart.sh`: Since this project's objective is to be easily destructible, I suppose you won't have your on-premise host always on 24/7, and sometimes the VMs will be turned off. In that case, every time you turn on the nodes, connect to `ansible_awx` and execute this script to restart the AWX environment. Due to the nature of the containers, after shutting them down they'll start failing if you restart them instead of recreate them; and don't worry, you won't lose any data in your AWX unless you destroy the Vagrant machine.

With AWX running and an administrator user created, use `https://localhost:10004/#/home` to log in the web ui. Change `localhost` with the correct IP if you have used a different computer.

---
## Troubleshooting
I have not found any more problems regarding the Vagrant VMs or the Docker containers, but if something goes wrong with AWX, just try to recreate the environment.

---
### Good practices and recommendations
Since this way of using AWX is easily destructible, I recommend you to use a Github repository to save all your playbooks.