class dynamicroute53::packages {

  apt::ppa { 'ppa:webupd8team/java': }

  package { 'openjdk-6-jdk':
    ensure => purged
  }

  package { 'openjdk-6-jre':
    ensure => purged
  }
  package { 'openjdk-7-jdk':
    ensure => purged
  }
  package { 'openjdk-7-jre':
    ensure => purged
  }

  package { 'oracle-java7-installer':
    ensure  => installed,
    require => [
      Apt::Ppa['ppa:webupd8team/java'],
      Package['openjdk-6-jdk'],
      Package['openjdk-6-jre'],
      Package['openjdk-7-jdk'],
      Package['openjdk-7-jre']
    ]
  }

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
