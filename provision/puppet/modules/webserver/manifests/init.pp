# Installs and configures Apache
class webserver (
  $drupal_version = '7.41',
  $drupal_database = 'drupal',
) {
  case $osfamily {
    'RedHat': {
      $curl = '/bin/curl'
      $mysql_package = 'mariadb-server'
      $mysql_service = 'mariadb'
      $php_mysql_package = 'php-mysql'
      $php_extensions = ['php-gd', 'php-xml', 'php-mbstring']
      $php_package = 'php'
      $web_configuration_directory = '/etc/httpd/conf.d'
      $web_package = 'httpd'
      $web_root = '/var/www/html'
      $web_service = 'httpd'
      $web_group = 'apache'
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
      $curl = '/usr/bin/curl'
      $mysql_package = 'mysql-server'
      $mysql_service = 'mysql'
      $php_mysql_package = 'php5-mysql'
      $php_extensions = ['php5-gd']
      $php_package = 'libapache2-mod-php5'
      $web_configuration_directory = '/etc/apache2/sites-available'
      $web_package = 'apache2'
      $web_root = '/var/www/html'
      $web_service = 'apache2'
      $web_group = 'www-data'
      file { "/etc/apache2/sites-enabled/vagrant":
        ensure  => link,
        target  => "${web_configuration_directory}/vagrant.conf",
        require => Package[$web_package],
        notify  => Service[$web_package],
      }
    }
  }

  $drupal_directory = "${web_root}/drupal-${drupal_version}"

  package { $php_extensions:
    notify => Service[$web_service],
  }
  package { $php_mysql_package: }

  package { $mysql_package: } ->
  service { $mysql_service:
    ensure => running,
    enable => true,
  }

  package { $web_package: } ->
  service { $web_service:
    ensure  => running,
    enable  => true,
    require => Package[$web_package],
  }

  package { $php_package:
    notify => Service[$web_service],
  }

  user { vagrant:
    groups  => ['vagrant', $web_group],
    require => Package[$web_package],
  }

  class { 'webserver::drupal':
    curl             => $curl,
    drupal_database  => $drupal_database,
    drupal_directory => $drupal_directory,
    drupal_version   => $drupal_version,
    mysql_service    => $mysql_service,
    web_package      => $web_package,
    web_root         => $web_root,
    web_group        => $web_group,
   }

}
