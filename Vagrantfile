Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox
  config.vm.define "ansible_awx" do |ansible_awx|
    ansible_awx.vm.box = "generic/ubuntu2204"
    ansible_awx.vm.hostname = "ansible-awx.local"
    ansible_awx.vm.network "private_network", ip: "10.100.1.10"
    ansible_awx.vm.network "forwarded_port", guest: 8043, host: 10004
    ansible_awx.vm.provider :virtualbox do |x|
      x.customize ["modifyvm", :id, "--ioapic", "on"]
      x.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      x.name = "ansible-awx"
      x.memory = 6144
      x.cpus = 6
    end
    ansible_awx.vm.synced_folder "./ansible_resources", "/home/vagrant/ansible_resources"
    # ansible_awx.vm.provision "shell", path: "./provisioning/setup_awx_minikube.sh"
    ansible_awx.vm.provision "shell", path: "./provisioning/dependencies_installation.sh"
  end
  ips = ["10.100.1.20", "10.100.1.30", "10.100.1.40"]
  (1..3).each do |i|
    config.vm.define "minion-#{i}" do |minion|
      minion.vm.box = "koalephant/debian10"
      minion.vm.network "private_network", ip: ips[i-1]
      minion.vm.provider "virtualbox" do |m|
        m.name = "minion-#{i}"
        m.memory = 512
        m.cpus = 1
      end
    end
  end
end
