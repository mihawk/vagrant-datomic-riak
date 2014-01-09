# vagrant-datomic-riak

This is a Vagrant project powered by Chef to bring up a local
[Datomic](http://www.datomic.com) instance backed by
[Riak](https://basho.com/riak/).

## Configuration

### Install Vagrant

Download and install Vagrant via the
[Vagrant installer](http://www.vagrantup.com/downloads.html).

### Install Vagrant plugins

``` bash
$ vagrant plugin install vagrant-berkshelf
$ vagrant plugin install vagrant-omnibus
$ vagrant plugin install vagrant-cachier
```

## Running

### Clone project repository

``` bash
$ git clone https://github.com/hectcastro/vagrant-datomic-riak.git
$ cd vagrant-datomic-riak
```

### Launch cluster

``` bash
$ export DATOMIC_RIAK_NODES=1
$ export DATOMIC_RIAK_CACHE=1 # Makes use of vagrant-cachier plugin
$ export DATOMIC_LICENSE_KEY="..."
$ vagrant up
```

### Environmental variables

- `DATOMIC_RIAK_NODES` – The number of node you want to spin up (default: `1`)
- `DATOMIC_RIAK_OS` – The operating system you want to use (`CENTOS` or
  `UBUNTU`, default: `CENTOS`)
- `DATOMIC_RIAK_CACHE` – Whether you want to allow Vagrant to use the
  [vagrant-cachier](https://github.com/fgrehm/vagrant-cachier) plugin or not
  (default: `false`)
- `DATOMIC_LICENSE_KEY` – The Datomic Pro license key

## Testing

### Install the Datomic Pro peer library

```bash
$ unzip datomic-pro-0.9.4360.zip
$ cd datomic-pro-0.9.4360
$ ./bin/maven-install
```

### Run test project

```bash
$ git clone https://github.com/hectcastro/vagrant-datomic-riak-test.git
$ cd vagrant-datomic-riak-test
$ lein run
```

A successful run should return something like this:

```
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/Users/hector/.m2/repository/org/slf4j/slf4j-nop/1.7.5/slf4j-nop-1.7.5.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/Users/hector/.m2/repository/org/slf4j/slf4j-log4j12/1.6.1/slf4j-log4j12-1.6.1.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.helpers.NOPLoggerFactory]
#<promise$settable_future$reify__4417@ed80876: {:db-before datomic.db.Db@da5ca3f3, :db-after datomic.db.Db@4b163359, :tx-data #<ArrayList [datomic.db.Datum@fc751ce5, datomic.db.Datum@ce599ea2]>, :tempids {-9223350046623220288 17592186045417}}>
#<HashSet [[17592186045417]]>
{:db/doc Hello world, :db/id 17592186045417}
{:db/ident :db/doc, :db/valueType :db.type/string, :db/cardinality :db.cardinality/one, :db/fulltext true, :db/doc Documentation string for an entity., :db/id 62}
```

## Vagrant box

The Vagrant box used in this project was created by
[Packer](http://www.packer.io). To view the Packer template, click
[here](https://github.com/opscode/bento/blob/master/packer/ubuntu-12.04-amd64.json).
