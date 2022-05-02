# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include paperless_ngx::preinstall
class paperless_ngx::preinstall inherits paperless_ngx {

  archive { "/usr/local/src/paperless-ngx-${paperless_version}.tar.xz":
    ensure        => present,
    extract       => true,
    extract_path  => "/usr/local/src/",
    source        => "https://github.com/paperless-ngx/paperless-ngx/releases/download/ngx-${paperless_version}/paperless-ngx-${paperless_version}.tar.xz",
    cleanup       => true,
  }

  exec { "mv /usr/local/src/paperless-ngx/ /opt/paperlessngx_${paperless_version}":
    command => "mv /usr/local/src/paperless-ngx/ /opt/paperlessngx_${paperless_version}",
    unless  => "test -d /opt/paperlessngx_${paperless_version}",
  } ~>
  ## Resource Type: file can't refreshonly
  # there are ~27000 files at the end - to much for "file"
  exec { "set rights to /opt/paperlessngx_${paperless_version}":
    command => "chown -R ${paperless_system_user}:${paperless_system_group} /opt/paperlessngx_${paperless_version}",
    refreshonly => true
  }
#  file { "/opt/paperlessngx_${paperless_version}":
#    ensure => 'directory',
#    owner  => $paperless_system_user,
#    group  => $paperless_system_group,
#    recurse => true,
#  }
  file { "/opt/paperless-ngx":
    ensure => 'link',
    target => "/opt/paperlessngx_${paperless_version}",
  }
  file { ["$paperless_consumption_dir","$paperless_data_dir","$paperless_media_root","$paperless_staticdir"]:
    ensure => 'directory',
    owner  => $paperless_system_user,
    group  => $paperless_system_group,
    mode   => "0750",
  }
  file { "/opt/paperless-ngx/paperless.conf":
    ensure => 'absent',
    backup => '.template',
  }
  file { "/etc/paperless.conf":
    ensure => 'file',
    source  => "file:///opt/paperless-ngx/paperless.conf.template",
    replace => false,
    owner  => $paperless_system_user,
    group  => $paperless_system_group,
  }

}
