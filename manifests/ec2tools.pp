class dynamicroute53::ec2tools {

  include dynamicroute53::packages

  file { '/etc/route53':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 700,
  }

  file { '/etc/route53/config':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 600,
    content => template('dynamicroute53/config.erb'),
    require => File['/etc/route53']
  }

  file { '/opt/aws':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 700,
  }

  exec { 'install_ec2_metatdata':
    command => 'wget -q -P /opt/aws http://s3.amazonaws.com/ec2metadata/ec2-metadata',
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    creates => '/opt/aws/ec2-metadata',
    require => [
      File['/opt/aws'],
      Package['cli53']
    ]
  }

  file { '/opt/aws/ec2-metadata':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 700,
    require => Exec['install_ec2_metatdata']
  }

  exec { 'install_ec2_tools':
    command => 'wget -q -P /opt/aws http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip && unzip -qq /opt/aws/ec2-api-tools.zip -d /opt/aws/ && rsync -a --no-o --no-g /opt/aws/ec2-api-tools-*/ /opt/aws/',
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    creates => '/opt/aws/bin',
    require => [
      File['/opt/aws'],
      Package['unzip'],
      Package['cli53']
    ]
  }

  file { '/etc/profile.d/aws.sh':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 600,
    source  => 'puppet:///modules/dynamicroute53/aws.sh',
    require => [
      Exec['install_ec2_metatdata'],
      Exec['install_ec2_tools'],
      File['/etc/route53/config']
    ]
  }

  file { '/etc/profile.d/java.sh':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 600,
    source => 'puppet:///modules/dynamicroute53/java.sh',
    require => [
      Exec['install_ec2_metatdata'],
      Exec['install_ec2_tools'],
      File['/etc/route53/config']
    ]
  }

}
