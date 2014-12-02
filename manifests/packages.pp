class dynamicroute53::packages {

  if ! defined(Package['python-pip']) {
    package { 'python-pip':
      ensure => installed,
    }
  }

  package { 'awscli':
    ensure   => installed,
    require  => Package['python-pip'],
    provider => pip,
  }

  package { 'cloud-utils':
    ensure => installed
  }

}
