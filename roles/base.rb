name "base"
description "Base role."
run_list(
  "recipe[ntp]",
  "recipe[java]",
  "recipe[openssh]"
)
default_attributes(
  "java" => {
    "install_flavor" => "oracle",
    "jdk_version" => 7,
    "oracle" => {
      "accept_oracle_download_terms" => true
    }
  },
  "openssh" => {
    "server" => {
      "password_authentication" => "no"
    }
  }
)
