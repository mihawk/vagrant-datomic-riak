name "datomic"
description "Role for Datomic nodes."
run_list(
  "recipe[datomic]"
)
default_attributes(
  "datomic" => {
    "version" => "0.9.4360",
    "checksum" => "9481654049ae4eb2965fb8be56904b9f0080d9f5d58be4fa77d19ef99bcc9fd2",
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
