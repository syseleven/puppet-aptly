# == Class: aptly::params
#
# Just holding the default values of the module. To overwrite something, do it
# on the target class.
#
class aptly::params {
  $version         = 'installed'
  $install_repo    = true
  $repo_location   = 'http://repo.aptly.info'
  $repo_release    = 'squeeze'
  $repo_repos      = 'main'
  $repo_keyserver  = 'keys.gnupg.net'
  $repo_key        = '26DA9D8630302E0B86A7A2CBED75B5A4483DA07C'
  $enable_service  = true
  $port            = '8080'
  $bind            = '0.0.0.0'
  $config_filepath = '/etc/aptly.conf'
  $manage_user     = true
  $user            = 'aptly'
  $uid             = 450
  $group           = 'aptly'
  $gid             = 450
  $properties      = {
    'downloadConcurrency'         => 4,
    'downloadSpeedLimit'          => 0,
    'dependencyFollowSuggests'    => false,
    'dependencyFollowRecommends'  => false,
    'dependencyFollowAllVariants' => false,
    'dependencyFollowSource'      => false,
    'gpgDisableSign'              => false,
    'gpgDisableVerify'            => false,
    'downloadSourcePackages'      => false,
    'rootDir'                     => '/var/aptly',
    'architectures'               => [$::architecture],
    'ppaDistributorID'            => 'ubuntu',
    'ppaCodename'                 => '',
    'S3PublishEndpoints'          => {},
    'SwiftPublishEndpoints'       => {},
    }
  $root_dir                 = $properties['rootDir']
  $architectures            = $properties['architectures']
  $ppa_dist                 = $properties['ppaDistributorID']
  $ppa_codename             = $properties['ppaCodename']
  $s3_publish_endpoints     = $properties['S3PublishEndpoints']
  $swift_publish_endpoints  = $properties['SwiftPublishEndpoints']
  $enable_api           = false
  $api_port             = 8081
  $api_bind             = '0.0.0.0'
  $api_nolock           = false
  $manage_xz_utils      = true
  $recurse_root_dir     = true
}
