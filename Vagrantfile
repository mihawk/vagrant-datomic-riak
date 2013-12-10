# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Ensure latest version of Chef is installed.
  config.omnibus.chef_version = :latest

  # Utilize the Cachier plugin to cache downloaded packages.
  config.cache.auto_detect = true

  # Utilize the Berkshelf plugin to resolve cookbook dependencies.
  config.berkshelf.enabled = true

  config.vm.box = "opscode-ubuntu-12.04"

  config.vm.provider :virtualbox do |vb, override|
    override.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box"

    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  config.vm.provider :vmware_fusion do |vm, override|
    override.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/vmware/opscode_ubuntu-12.04_chef-provisionerless.box"

    vm.vmx["memsize"] = "2048"
    vm.vmx["numvcpus"] = "2"
  end

  # Provision using Chef.
  config.vm.provision :chef_solo do |chef|
    chef.roles_path = "roles"

    chef.add_role "base"
    chef.add_role "riak"
    #chef.add_role "datomic"

    chef.json = { }
  end
end
