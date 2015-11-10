class webserver::drupal (
  $curl,
  $drupal_database,
  $drupal_directory,
  $drupal_version,
  $mysql_service,
  $web_package,
  $web_root,
  $web_group,
) {

  exec { 'download-drupal':
    command => "${curl} http://ftp.drupal.org/files/projects/drupal-${drupal_version}.tar.gz -o ${web_root}/drupal-${drupal_version}.tgz",
    unless  => "/bin/ls ${web_root}/drupal-${drupal_version}.tgz",
    require => Package[$web_package],
  } ->
  exec { 'extract-drupal':
    command => "/bin/tar -zxvf ${web_root}/drupal-${drupal_version}.tgz -C ${web_root}",
    unless  => "/bin/ls ${web_root}/drupal-${drupal_version}",
  } ->
  file { "${web_root}/drupal":
    ensure => link,
    target => $drupal_directory,
  } ->
  exec { "/bin/chown -R ${web_group}:${web_group} ${drupal_directory}": } ->
  exec { "/bin/chmod -R g+w ${drupal_directory}": } ->
  file { "${drupal_directory}/sites/default/settings.php":
    ensure => link,
    target => "${drupal_directory}/sites/default/default.settings.php",
  }

  exec { "/usr/bin/mysql -u root -e \"create database ${drupal_database}\"":
    unless  => "/usr/bin/mysql -u root -e 'show databases' | /bin/grep -w ^${drupal_database}$",
    require => Service[$mysql_service],
  }

}
