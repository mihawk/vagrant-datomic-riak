# -*- mode: ruby -*-
# vi: set ft=ruby :

CENTOS = {
  box: "opscode-centos-6.5",
  virtualbox_url: "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box",
  vmware_fusion_url: "http://opscode-vm-bento.s3.amazonaws.com/vagrant/vmware/opscode_centos-6.5_chef-provisionerless.box"
}
UBUNTU = {
  box: "opscode-ubuntu-12.04",
  virtualbox_url: "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box",
  vmware_fusion_url: "http://opscode-vm-bento.s3.amazonaws.com/vagrant/vmware/opscode_ubuntu-12.04_chef-provisionerless.box"
}

VAGRANTFILE_API_VERSION = "2"
NODES = ENV["DATOMIC_RIAK_NODES"].nil? ? 1 : ENV["DATOMIC_RIAK_NODES"].to_i
OS = ENV["DATOMIC_RIAK_OS"].nil? ? CENTOS : Kernel.const_get(ENV["DATOMIC_RIAK_OS"])

Vagrant.configure(VAGRANTFILE_API_VERSION) do |cluster|
  # Ensure latest version of Chef is installed.
  cluster.omnibus.chef_version = :latest

  # Utilize the Cachier plugin to cache downloaded packages.
  if Vagrant.has_plugin?("vagrant-cachier") && !ENV["DATOMIC_RIAK_CACHE"].nil?
    cluster.cache.scope = :box
  end

  # Utilize the Berkshelf plugin to resolve cookbook dependencies.
  cluster.berkshelf.enabled = true

  (1..NODES).each do |index|
    last_octet = index * 10

    cluster.vm.define "riak#{index}".to_sym do |config|
      config.vm.box = OS[:box]


      config.vm.provider :virtualbox do |vb, override|
        override.vm.box_url = OS[:virtualbox_url]

        vb.customize ["modifyvm", :id, "--memory", "1024"]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
      end

      config.vm.provider :vmware_fusion do |vm, override|
        override.vm.box_url = OS[:vmware_fusion_url]

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
            "license_key" => (ENV["DATOMIC_LICENSE_KEY"].nil? ? "" : ENV["DATOMIC_LICENSE_KEY"]),
            "license_email" => (ENV["DATOMIC_LICENSE_EMAIL"].nil? ? "" : ENV["DATOMIC_LICENSE_EMAIL"]),
            "license_download_key" => (ENV["DATOMIC_LICENSE_DOWNLOAD_KEY"].nil? ? "" : ENV["DATOMIC_LICENSE_DOWNLOAD_KEY"])
          }
        }
      end
    end
  end
end
