# vagrant-datomic-riak

This is a Vagrant project powered by Chef to bring up a local
[Datomic](http://www.datomic.com) instance backed by
[Riak](https://basho.com/riak/).

## Configuration

### Install Vagrant

Download and install Vagrant via the
[Vagrant installer](http://downloads.vagrantup.com/).

### Install Vagrant plugins

``` bash
$ vagrant plugin install vagrant-berkshelf
$ vagrant plugin install vagrant-omnibus
$ vagrant plugin install vagrant-cachier
```

### Clone repository

``` bash
$ git clone https://github.com/hectcastro/vagrant-datomic-riak.git
$ cd vagrant-datomic-riak
```

### Launch cluster

``` bash
$ vagrant up
```

### Test cluster

TBD

## Vagrant box

The Vagrant box used in this project was created by
[Packer](http://www.packer.io). To view the Packer template, click
[here](https://github.com/opscode/bento/blob/master/packer/ubuntu-12.04-amd64.json).
