class dynamicroute53(
    $domain         = undef,
    $region         = undef,
    $aws_access_id  = undef,
    $aws_secret_key = undef,
    $hosted_zone_id = undef,
    $private_dns    = false,
    $ttl            = '300'
  ) {

  class {'dynamicroute53::packages':} -> class {'dynamicroute53::service':}

}
