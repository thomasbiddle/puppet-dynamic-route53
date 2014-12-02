class dynamicroute53(
    $domain         = undef,
    $region         = undef,
    $aws_access_id  = undef,
    $aws_secret_key = undef,
    $hosted_zone_id = undef,
    $private_dns    = false,
    $ttl            = '300'
  ) {

  file { '/root/.aws/':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 755
  }

  file { '/root/.aws/credentials':
    ensure   => present,
    owner    => root,
    group    => root,
    mode     => 600,
    content => template('dynamicroute53/credentials.erb'),
    require  => [
      File['/root/.aws/'],
      Package['awscli'],
      Package['cloud-utils']
    ]
  }

  file { '/root/.aws/config':
    ensure   => present,
    owner    => root,
    group    => root,
    mode     => 600,
    content => template('dynamicroute53/config.erb'),
    require  => [
      File['/root/.aws/'],
      Package['awscli'],
      Package['cloud-utils']
    ]
  }

  class {'dynamicroute53::packages':} -> class {'dynamicroute53::service':}

}
