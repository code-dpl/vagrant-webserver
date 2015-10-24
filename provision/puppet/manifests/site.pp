node default {
  notify {"Node ${fqdn} has no definition":}
}

node 'cent7' {
  include webserver
}

node 'trusty' {
  include webserver
}
