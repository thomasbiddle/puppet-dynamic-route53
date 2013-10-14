class dynamicroute53(
    $domain         = undef,
    $region         = undef,
    $aws_access_id  = undef,
    $aws_secret_key = undef,
    $ttl            = '300'
  ) {

  include dynamicroute53::packages

  class {'dynamicroute53::ec2tools':} -> class {'dynamicroute53::service':}

}
