class dynamicroute53::packages {

  package { 'python-pip':
    ensure => installed
  }

  package { 'cli53':
     ensure   => installed,
     require  => Package['python-pip'],
     provider => pip,
  }

  package { 'unzip':
    ensure => installed
  }

}
