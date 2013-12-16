name "zookeeper"
description "Role for Zookeeper nodes."
run_list(
  "recipe[zookeeper]"
)
default_attributes(
  "zookeeper" => {
    "version" => "3.4.5",
    "checksum" => "e92b634e99db0414c6642f6014506cc22eefbea42cc912b57d7d0527fb7db132",
    "tick_time" => "2000",
    "host" => "33.33.33.10.xip.io",
    "port" => "2181"
  }
)
