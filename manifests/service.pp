class dynamicroute53::service {

  file { '/usr/sbin/update-dns-route53':
    ensure  => present,
    content => template('dynamicroute53/update-dns-route53.erb'),
    owner   => root,
    group   => root,
    mode    => 754
  }

  file { '/usr/sbin/delete-dns-route53':
    ensure  => present,
    content => template('dynamicroute53/delete-dns-route53.erb'),
    owner   => root,
    group   => root,
    mode    => 754
  }

  file { '/etc/init.d/updatednsroute53':
    ensure  => present,
    source  => 'puppet:///modules/dynamicroute53/updatednsroute53',
    owner   => root,
    group   => root,
    mode    => 754,
    require => [
      File['/usr/sbin/update-dns-route53'],
      File['/usr/sbin/delete-dns-route53']
    ]
  }

  service { 'updatednsroute53':
    ensure  => running,
    require => File['/etc/init.d/updatednsroute53']
  }

}
