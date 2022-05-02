# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include paperless_ngx::services
class paperless_ngx::services inherits paperless_ngx {

  $systemd_services = ['paperless-consumer.service','paperless-scheduler.service','paperless-webserver.service']

  each($systemd_services) |$service| {

    ## copy systemd services
    file { "/etc/systemd/system/${service}":
      ensure  => 'file',
      source  => "file://${paperless_directory}/scripts/${service}",
      replace => false,
    }

    ## configure security options for systemd services
    file_line{ "security options ProtectSystem for ${service}":
      path  => "/etc/systemd/system/${service}",
      after => '\[Service\]',
      line  => 'ProtectSystem=full',
    }
    file_line{ "security options NoNewPrivileges for ${service}":
      path  => "/etc/systemd/system/${service}",
      after => '\[Service\]',
      line  => 'NoNewPrivileges=true',
    }
    file_line{ "security options PrivateUsers for ${service}":
      path  => "/etc/systemd/system/${service}",
      after => '\[Service\]',
      line  => 'PrivateUsers=true',
    }
    file_line{ "security options PrivateDevices for ${service}":
      path  => "/etc/systemd/system/${service}",
      after => '\[Service\]',
      line  => 'PrivateDevices=true',
    }
    file_line{ "set WorkingDirectory for ${service}":
      path  => "/etc/systemd/system/${service}",
      match => '^WorkingDirectory=',
      line  => "WorkingDirectory=${paperless_directory}/src",
    }
    file_line{ "set user for ${service}":
      path  => "/etc/systemd/system/${service}",
      match => '^User=',
      line  => "User=${paperless_ngx::paperless_system_user}",
    }
    file_line{ "set group for ${service}":
      path  => "/etc/systemd/system/${service}",
      match => '^Group=',
      line  => "Group=${paperless_ngx::paperless_system_group}",
    }

    service { $service:
      ensure => running,
      enable => true,
    }

  }

  file_line{ 'set ExecStart for paperless-consumer.service':
    path   => '/etc/systemd/system/paperless-consumer.service',
    match  => '^ExecStart=',
    line   => "ExecStart=${paperless_ngx::paperless_virtualenv}/bin/python3 manage.py document_consumer",
    notify => Service['paperless-consumer.service']
  }
  file_line{ 'set ExecStart for paperless-scheduler.service':
    path   => '/etc/systemd/system/paperless-scheduler.service',
    match  => '^ExecStart=',
    line   => "ExecStart=${paperless_ngx::paperless_virtualenv}/bin/python3 manage.py qcluster",
    notify => Service['paperless-scheduler.service']
  }
  file_line{ 'set ExecStart for paperless-webserver.service':
    path   => '/etc/systemd/system/paperless-webserver.service',
    match  => '^ExecStart=',
    line   => "ExecStart=${paperless_ngx::paperless_virtualenv}/bin/gunicorn -c ${paperless_ngx::paperless_directory}/gunicorn.conf.py paperless.asgi:application",
    notify => Service['paperless-webserver.service']

  }

}
