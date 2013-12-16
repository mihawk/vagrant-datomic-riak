# -*- mode: ruby -*-
# vi: set ft=ruby :

NODES = ENV["DATOMIC_RIAK_NODES"].nil? ? 1 : ENV["DATOMIC_RIAK_NODES"].to_i

Vagrant.configure("2") do |cluster|
  # Ensure latest version of Chef is installed.
  cluster.omnibus.chef_version = :latest

  # Utilize the Cachier plugin to cache downloaded packages.
  unless ENV["DATOMIC_RIAK_CACHE"].nil?
    cluster.cache.auto_detect = true
  end

  # Utilize the Berkshelf plugin to resolve cookbook dependencies.
  cluster.berkshelf.enabled = true

  (1..NODES).each do |index|
    last_octet = index * 10

    cluster.vm.define "riak#{index}".to_sym do |config|
      config.vm.box = "opscode-centos-6.5"

      config.vm.provider :virtualbox do |vb, override|
        override.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box"

        vb.customize ["modifyvm", :id, "--memory", "1024"]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
      end

      config.vm.provider :vmware_fusion do |vm, override|
        override.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/vmware/opscode_centos-6.5_chef-provisionerless.box"

        vm.vmx["memsize"] = "1024"
        vm.vmx["numvcpus"] = "2"
      end

      config.vm.hostname = "riak#{index}"
      config.vm.network :private_network, ip: "33.33.33.#{last_octet}"

      # Provision using Chef.
      config.vm.provision :chef_solo do |chef|
        chef.roles_path = "roles"

        chef.add_role "base"
        chef.add_role "riak"

        if index == 1
          chef.add_role "zookeeper"
          chef.add_role "datomic"
        end

        chef.json = {
          "riak" => {
            "args" => {
              "-name" => "riak@33.33.33.#{last_octet}.xip.io"
            },
            "config" => {
              "riak_api" => {
                "pb" =>
                  { "__string_33.33.33.#{last_octet}" => 8087 }
              },
              "riak_core" => {
                "http" =>
                  { "__string_33.33.33.#{last_octet}" => 8098 }
              }
            }
          },
          "datomic" => {
            "license_key" => (ENV["DATOMIC_LICENSE_KEY"].nil? ? "" : ENV["DATOMIC_LICENSE_KEY"])
          }
        }
      end
    end
  end
end
