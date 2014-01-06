name "base"
description "Base role."
run_list(
  "recipe[yum]",
  "recipe[ntp]",
  "recipe[java]",
  "recipe[openssh]"
)
default_attributes(
  "java" => {
    "install_flavor" => "oracle",
    "jdk_version" => 7,
    "tarball" => "http://download.oracle.com/otn/java/jdk/7u25-b15/jdk-7u25-linux-x64.tar.gz",
    "tarball_checksum" => "f80dff0e19ca8d038cf7fe3aaa89538496b80950f4d10ff5f457988ae159b2a6",
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
