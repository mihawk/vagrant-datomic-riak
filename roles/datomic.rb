name "datomic"
description "Role for Datomic nodes."
run_list(
  "recipe[datomic]"
)
default_attributes(
  "datomic" => {
    "version" => "0.9.4699",
    "checksum" => "c76148848c7a4c46b95157db2a15205e6b28e469b4a7df0bd659f9c180f3bbdf",
    "host" => "33.33.33.10.xip.io",
    "port" => 4334,
    "protocol" => "riak",
    "riak_host" => "33.33.33.10.xip.io",
    "riak_port" => 8087,
    "riak_interface" => "protobuf",
    "riak_bucket" => "datomic",
    "write_concurrency" => 4,
    "read_concurrency" => 8,
    "heartbeat_interval" => 10000
  }
)
