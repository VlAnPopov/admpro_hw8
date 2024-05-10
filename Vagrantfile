# -*- mode: ruby -*-
# vi: set ft=ruby :

boxes = [
  { :name => "nfsserver", :box => "centos/7", :memory => 2048, :cpus => 2, :script => 'server.sh', :ip => "192.168.56.200"},
  { :name => "nfsclient", :box => "centos/7", :memory => 2048, :cpus => 2, :script => 'client.sh', :ip => "192.168.56.201"},
 ]

Vagrant.configure("2") do |config|

  boxes.each do |box|
    config.vm.define box[:name] do |target|
      target.vm.provider "virtualbox" do |v|
        v.name = box[:name]
        v.memory = box[:memory]
        v.cpus = box[:cpus]
      end
      target.vm.network "private_network", ip: box[:ip], name: "VirtualBox Host-Only Ethernet Adapter"
      target.vm.synced_folder ".", "/vagrant"
      target.vm.box = box[:box]
      target.vm.hostname = box[:name]
      target.vm.provision "shell", path: box[:script]
    end
  end
end