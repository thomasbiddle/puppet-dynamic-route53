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

  file { '/var/local/oracle-java7.preseed':
    ensure => present,
    source => 'puppet:///modules/dynamicroute53/oracle-java7.preseed'
  }

  # !!! By installing this package - you agree to Oracle's license.
  package { 'oracle-java7-installer':
    ensure       => installed,
    responsefile => '/var/local/oracle-java7.preseed',
    require      => [
      Apt::Ppa['ppa:webupd8team/java'],
      Package['openjdk-6-jdk'],
      Package['openjdk-6-jre'],
      Package['openjdk-7-jdk'],
      Package['openjdk-7-jre']
    ]
  }

  if ! defined(Package['python-pip']) {
    package { 'python-pip':
      ensure => installed,
    }
  }

  package { 'cli53':
     ensure   => installed,
     require  => Package['python-pip'],
     provider => pip,
  }

  if ! defined(Package['unzip']) {
    package { 'unzip':
      ensure => installed,
    }
  }

}
