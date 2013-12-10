name "base"
description "Base role."
run_list(
  "recipe[yum]",
  "recipe[sysctl]",
  "recipe[ntp]",
  "recipe[java]",
  "recipe[openssh]"
)
default_attributes(
  "sysctl" => {
    "params" => {
      "vm" => {
        "swappiness" => 0
      },
      "net" => {
        "core" => {
          "somaxconn" => 4000
        },
        "ipv4" => {
          "tcp_max_syn_backlog" => 40000,
          "tcp_timestamps" => 0,
          "tcp_sack" => 1,
          "tcp_window_scaling" => 1,
          "tcp_fin_timeout" => 15,
          "tcp_keepalive_intvl" => 30,
          "tcp_tw_reuse" => 1
        }
      }
    }
  },
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
