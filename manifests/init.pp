# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include paperless_ngx
class paperless_ngx (
  Boolean $manage_package             = true,
  Boolean $manage_service             = true,
  Boolean $manage_database            = true,
  String  $package_ensure             = present,
  String  $service_ensure             = running,
  Boolean $service_enable             = true,
  Boolean $manage_repo                = true,
  Boolean $manage_user                = true,

  Boolean $manage_redis               = true,



  $paperless_redis_host = $paperless_ngx::params::paperless_redis_host,
  $paperless_redis_port = $paperless_ngx::params::paperless_redis_port,
  $paperless_redis = $paperless_ngx::params::paperless_redis,
  $paperless_db_type = $paperless_ngx::params::paperless_db_type,
  $paperless_db_host = $paperless_ngx::params::paperless_db_host,
  $paperless_db_port = $paperless_ngx::params::paperless_db_port,
  $paperless_db_name = $paperless_ngx::params::paperless_db_name,
  $paperless_db_user = $paperless_ngx::params::paperless_db_user,
  $paperless_db_pass = $paperless_ngx::params::paperless_db_pass,
  $paperless_db_sslmode = $paperless_ngx::params::paperless_db_sslmode,
  $paperless_directory = $paperless_ngx::params::paperless_directory,
  $paperless_consumption_dir = $paperless_ngx::params::paperless_consumption_dir,
  $paperless_data_dir = $paperless_ngx::params::paperless_data_dir,
  $paperless_trash_dir = $paperless_ngx::params::paperless_trash_dir,
  $paperless_media_root = $paperless_ngx::params::paperless_media_root,
  $paperless_staticdir = $paperless_ngx::params::paperless_staticdir,
  $paperless_filename_format = $paperless_ngx::params::paperless_filename_format,
  $paperless_logging_dir = $paperless_ngx::params::paperless_logging_dir,
  $paperless_virtualenv = $paperless_ngx::params::paperless_virtualenv,
  $paperless_secret_key = $paperless_ngx::params::paperless_secret_key,
  $paperless_allowed_hosts = $paperless_ngx::params::paperless_allowed_hosts,
  $paperless_cors_allowed_hosts = $paperless_ngx::params::paperless_cors_allowed_hosts,
  $paperless_force_script_name = $paperless_ngx::params::paperless_force_script_name,
  $paperless_static_url = $paperless_ngx::params::paperless_static_url,
  $paperless_auto_login_username = $paperless_ngx::params::paperless_auto_login_username,
  $paperless_cookie_prefix = $paperless_ngx::params::paperless_cookie_prefix,
  $paperless_enable_http_remote_user = $paperless_ngx::params::paperless_enable_http_remote_user,
  $paperless_url = $paperless_ngx::params::paperless_url,

  $paperless_ocr_language = $paperless_ngx::params::paperless_ocr_language,
  $paperless_ocr_languages = $paperless_ngx::params::paperless_ocr_languages,
  $paperless_ocr_mode = $paperless_ngx::params::paperless_ocr_mode,
  $paperless_ocr_clean = $paperless_ngx::params::paperless_ocr_clean,
  $paperless_ocr_deskew = $paperless_ngx::params::paperless_ocr_deskew,
  $paperless_ocr_rotate_pages = $paperless_ngx::params::paperless_ocr_rotate_pages,
  $paperless_ocr_rotate_pages_threshold = $paperless_ngx::params::paperless_ocr_rotate_pages_threshold,
  $paperless_ocr_output_type = $paperless_ngx::params::paperless_ocr_output_type,
  $paperless_ocr_pages = $paperless_ngx::params::paperless_ocr_pages,
  $paperless_ocr_image_dpi = $paperless_ngx::params::paperless_ocr_image_dpi,
  $paperless_ocr_user_args = $paperless_ngx::params::paperless_ocr_user_args,
  $paperless_use_jbig2enc = $paperless_ngx::params::paperless_use_jbig2enc,
  $paperless_big2enc_lossy = $paperless_ngx::params::paperless_big2enc_lossy,
  $paperless_tika_enabled = $paperless_ngx::params::paperless_tika_enabled,
  $paperless_tika_endpoint = $paperless_ngx::params::paperless_tika_endpoint,
  $paperless_tika_gotenberg_endpoint = $paperless_ngx::params::paperless_tika_gotenberg_endpoint,
  $paperless_time_zone = $paperless_ngx::params::paperless_time_zone,
  $paperless_consumer_polling = $paperless_ngx::params::paperless_consumer_polling,
  $paperless_consumer_delete_duplicates = $paperless_ngx::params::paperless_consumer_delete_duplicates,
  $paperless_consumer_recursive = $paperless_ngx::params::paperless_consumer_recursive,
  $paperless_consumer_subdirs_as_tags = $paperless_ngx::params::paperless_consumer_subdirs_as_tags,
  $paperless_convert_memory_limit = $paperless_ngx::params::paperless_convert_memory_limit,
  $paperless_convert_tmpdir = $paperless_ngx::params::paperless_convert_tmpdir,
  $paperless_optimize_thumbnails = $paperless_ngx::params::paperless_optimize_thumbnails,
  $paperless_pre_consume_script = $paperless_ngx::params::paperless_pre_consume_script,
  $paperless_post_consume_script = $paperless_ngx::params::paperless_post_consume_script,
  $paperless_filename_date_order = $paperless_ngx::params::paperless_filename_date_order,
  $paperless_thumbnail_font_name = $paperless_ngx::params::paperless_thumbnail_font_name,
  $paperless_ignore_dates = $paperless_ngx::params::paperless_ignore_dates,
  $paperless_superuser_name = $paperless_ngx::params::paperless_superuser_name,
  $paperless_superuser_email = $paperless_ngx::params::paperless_superuser_email,
  $paperless_superuser_password = $paperless_ngx::params::paperless_superuser_password,
  $paperless_system_user = $paperless_ngx::params::paperless_system_user,
  $paperless_system_group = $paperless_ngx::params::paperless_system_group,
  $paperless_listen_address = $paperless_ngx::params::paperless_listen_address,
  $paperless_listen_port = $paperless_ngx::params::paperless_listen_port,
  $paperless_package_name = $paperless_ngx::params::paperless_package_name,
  $ocrmypdf_package_name = $paperless_ngx::params::ocrmypdf_package_name,
  $dev_package_name = $paperless_ngx::params::dev_package_name,
  $redis_package_name = $paperless_ngx::params::redis_package_name,

) inherits paperless_ngx::params {

  Exec { path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/' }

  if $manage_package {
    package { $paperless_package_name:
      ensure => $package_ensure,
    }
    package { $ocrmypdf_package_name:
      ensure => $package_ensure,
    }
#    package { $dev_package_name:
#      ensure => $package_ensure,
#    }


    each($paperless_ocr_languages) |$language| {

      package { "tesseract-ocr-${language}":
        ensure => $package_ensure,
      }
    }
  }


#  if $manage_repo {
#    apt::source { 'puppetlabs':
#      location => 'http://apt.puppetlabs.com',
#      repos    => 'main',
##      key      => {
##        'id'     => '6F6B15509CF8E59E6E469F327F438280EF8D349F',
##        'server' => 'pgp.mit.edu',
##      },
#}


  if $manage_redis {
    package { $paperless_ngx::params::redis_package_name:
      ensure => $package_ensure,
    }

    service { 'redis-server':
      ensure     => running, 
      enable     => true, 
      require    => Package[$paperless_ngx::params::redis_package_name],
    }
  }


  if $manage_user {
    group { $paperless_system_group: }

    user { $paperless_system_user: 
      groups     => $paperless_system_group,
      home       => $paperless_directory,
#      managehome => true,
      system     => true,
      shell      => "/usr/sbin/nologin",
    }
  }



  class { 'paperless_ngx::preinstall': }
  class { 'paperless_ngx::config': }
  class { 'paperless_ngx::install': }
  class { 'paperless_ngx::services': }


}
