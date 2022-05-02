# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include paperless_ngx::config
class paperless_ngx::config (
) inherits paperless_ngx {


  $global_vars = [
    'PAPERLESS_REDIS',
    'PAPERLESS_CONSUMPTION_DIR',
    'PAPERLESS_DATA_DIR',
    'PAPERLESS_TRASH_DIR',
    'PAPERLESS_MEDIA_ROOT',
    'PAPERLESS_STATICDIR',
    'PAPERLESS_FILENAME_FORMAT',
    'PAPERLESS_LOGGING_DIR',
    'PAPERLESS_SECRET_KEY',
    'PAPERLESS_ALLOWED_HOSTS',
    'PAPERLESS_CORS_ALLOWED_HOSTS',
    'PAPERLESS_FORCE_SCRIPT_NAME',
    'PAPERLESS_STATIC_URL',
    'PAPERLESS_AUTO_LOGIN_USERNAME',
    'PAPERLESS_COOKIE_PREFIX',
    'PAPERLESS_ENABLE_HTTP_REMOTE_USER',
    'PAPERLESS_URL',
    'PAPERLESS_OCR_LANGUAGE',
    'PAPERLESS_OCR_MODE',
    'PAPERLESS_OCR_CLEAN',
    'PAPERLESS_OCR_DESKEW',
    'PAPERLESS_OCR_ROTATE_PAGES',
    'PAPERLESS_OCR_ROTATE_PAGES_THRESHOLD',
    'PAPERLESS_OCR_OUTPUT_TYPE',
    'PAPERLESS_OCR_PAGES',
    'PAPERLESS_OCR_IMAGE_DPI',
    'PAPERLESS_OCR_USER_ARGS',
    'PAPERLESS_TIKA_ENABLED',
    'PAPERLESS_TIKA_ENDPOINT',
    'PAPERLESS_TIKA_GOTENBERG_ENDPOINT',
    'PAPERLESS_TIME_ZONE',
    'PAPERLESS_CONSUMER_POLLING',
    'PAPERLESS_CONSUMER_DELETE_DUPLICATES',
    'PAPERLESS_CONSUMER_RECURSIVE',
    'PAPERLESS_CONSUMER_SUBDIRS_AS_TAGS',
    'PAPERLESS_CONVERT_MEMORY_LIMIT',
    'PAPERLESS_CONVERT_TMPDIR',
    'PAPERLESS_OPTIMIZE_THUMBNAILS',
    'PAPERLESS_PRE_CONSUME_SCRIPT',
    'PAPERLESS_POST_CONSUME_SCRIPT',
    'PAPERLESS_FILENAME_DATE_ORDER',
    'PAPERLESS_THUMBNAIL_FONT_NAME',
    'PAPERLESS_IGNORE_DATES',
  ]

  ## loop all variables
  # eg. PAPERLESS_REDIS=$paperless_redis
  each($global_vars) |$key| {
    $value = getvar("${key.downcase}")

    file_line{ $key:
      path   => '/etc/paperless.conf',
      match  => "${key}=",
      line   => "${key}=${value}",
      notify => Service['paperless-consumer.service', 'paperless-scheduler.service', 'paperless-webserver.service'],
    }
  }

  if ($paperless_db_type == 'postgresql') {
    ## configure paperless-ng

    $postgresql_vars = [
      'PAPERLESS_DBHOST',
      'PAPERLESS_DBPORT',
      'PAPERLESS_DBNAME',
      'PAPERLESS_DBUSER',
      'PAPERLESS_DBPASS',
      'PAPERLESS_DBSSLMODE'
    ]

    each($postgresql_vars) |$key| {

      $value = getvar("${key.downcase}")

      file_line{ $key:
        path   => '/etc/paperless.conf',
        match  => "${key}=",
        line   => "${key}=${value}",
        notify => Service['paperless-consumer.service', 'paperless-scheduler.service', 'paperless-webserver.service'],
      }
    }
  } else {
    ## configure paperless-ng database [sqlite]
    file_line{ 'PAPERLESS_DBHOST':
      path   => '/etc/paperless.conf',
      match  => 'PAPERLESS_DBHOST=',
      line   => "#PAPERLESS_DBHOST=${paperless_db_host}",
      notify => Service['paperless-consumer.service', 'paperless-scheduler.service', 'paperless-webserver.service'],
    }
  }

  file_line{ 'configure ghostscript for PDF':
    path  => '/etc/ImageMagick-6/policy.xml',
    match => '(\s+)<policy domain="coder" rights=".*" pattern="PDF" />',
    line  => '  <policy domain="coder" rights="read|write" pattern="PDF" />'
  }

  file_line{ 'configure gunicorn web server':
    path   => "${paperless_directory}/gunicorn.conf.py",
    match  => '^bind = ',
    line   => "bind = '${paperless_listen_address}:${paperless_listen_port}'",
    notify => Service['paperless-webserver.service'],
  }

}
