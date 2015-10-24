# Installs and configures Apache
class webserver {
  case $osfamily {
    'RedHat': {
      $web_package = 'httpd'
      $configuration_directory = '/etc/httpd/conf.d'
      if ( $operatingsystemmajrelease >= 7 ) {
        service { 'firewalld':
          enable => true,
          ensure => running,
        }
        file { '/etc/firewalld/zones/public.xml':
          content => template("${module_name}/public.xml.erb"),
          notify  => Service['firewalld'],
        } 
      }
    }
    'Debian': {
      $web_package = 'apache2'
      $configuration_directory = '/etc/apache2/sites-available'
      file { "/etc/apache2/sites-enabled/vagrant":
        ensure  => link,
        target  => "${configuration_directory}/vagrant.conf",
        require => Package[$web_package],
        notify  => Service[$web_package],
      }
    }
  }

  package { $web_package: }

  service { $web_package:
    ensure  => running,
    enable  => true,
    require => Package[$web_package],
  }

  file { "${configuration_directory}/vagrant.conf":
    content => template("${module_name}/vagrant.conf.erb"),
    require => Package[$web_package],
    notify  => Service[$web_package],
  }

  file { "${configuration_directory}/welcome.conf":
    ensure  => absent,
    require => Package[$web_package],
    notify  => Service[$web_package],
  }

  file { '/var/www/html/vagrant':
    ensure => link,
    target => '/vagrant',
    require => Package[$web_package],
  }

}
