name "riak"
description "Role for Riak nodes."
run_list(
  "recipe[riak]"
)
default_attributes(
  "riak" => {
    "args" => {
      "-name" => "riak@127.0.0.1",
      "+zdbbl" => 32768
    },
    "config" => {
      "riak_api" => {
        "pb" =>
          { "__string_127.0.0.1" => 8087 }
      },
      "riak_core" => {
        "http" =>
          { "__string_127.0.0.1" => 8098 }
      },
      "riak_kv" => {
        "anti_entropy_concurrency" => 1,
        "map_js_vm_count" => 0,
        "reduce_js_vm_count" => 0,
        "hook_js_vm_count" => 0
      }
    }
  }
)
