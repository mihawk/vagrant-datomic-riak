name "riak"
description "Role for Riak nodes."
run_list(
  "recipe[riak]"
)
default_attributes(
  "riak" => {
    "args" => {
      "+zdbbl" => 32768
    },
    "config" => {
      "riak_core" => {
        "ring_creation_size" => 8,
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
