# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include paperless_ngx::params
class paperless_ngx::params {

#  $paperlessngx_version = 'latest'
  $paperless_version = '1.7.0'

#  $paperless_redis_host = 'localhost'

#  $paperless_system_user = "paperlessngx"
#  $paperless_system_group = "paperlessngx"


#  $paperless_directory        = "/opt/paperless-ngx"
#  $paperless_consumption_dir  = "${paperless_directory}/consumption"
#  $paperless_data_dir         = "$paperless_directory/data"
##  $paperless_trash_dir
#  $paperless_media_root       = "${paperless_directory}/media"
#  $paperless_staticdir        = "${paperless_directory}/static"
##  $paperless_filename_format:
#  $paperless_logging_dir      = "${paperless_data_dir}/log"
#  $paperless_virtualenv       = "${paperless_directory}/.venv"


  # Required services
  $paperless_redis_host = 'localhost'
  $paperless_redis_port = '6379'
  $paperless_redis      = "redis://${paperless_redis_host}:${paperless_redis_port}"

  $paperless_db_type    = 'sqlite' # or postgresql
  # Below entries only apply for paperlessng_db_type=='postgresql'
  $paperless_db_host    = 'localhost'
  $paperless_db_port    = '5432'
  $paperless_db_name    = 'paperlessngx'
  $paperless_db_user    = 'paperlessngx'
  $paperless_db_pass    = 'paperlessngx'
  $paperless_db_sslmode = 'prefer'

  # Paths and folders
  $paperless_directory  = "/opt/paperless-ngx"
  $paperless_consumption_dir = "${paperless_directory}/consumption"
  $paperless_data_dir   = "${paperless_directory}/data"
  $paperless_trash_dir  = ''
  $paperless_media_root = "${paperless_directory}/media"
  $paperless_staticdir  = "${paperless_directory}/static"
  $paperless_filename_format = ''
  $paperless_logging_dir = "${paperless_data_dir}/log"
  $paperless_virtualenv  = "${paperless_directory}/.venv"

  # Hosting & Security
  $paperless_secret_key = 'PLEASECHANGETHISFORTHELOVEOFGOD'
  $paperless_allowed_hosts = "*"
  $paperless_cors_allowed_hosts = "http://localhost:8000"
  $paperless_force_script_name = ''
  $paperless_static_url = '/static/'
  $paperless_auto_login_username = ''
  $paperless_cookie_prefix = ""
  $paperless_enable_http_remote_user = 'False'
  $paperless_url = ""

  # OCR settings
  $paperless_ocr_language = 'eng'
  $paperless_ocr_languages = ['eng']
  $paperless_ocr_mode = 'skip'
  $paperless_ocr_clean = 'clean'
  $paperless_ocr_deskew = 'True'
  $paperless_ocr_rotate_pages = 'True'
  $paperless_ocr_rotate_pages_threshold = '12'
  $paperless_ocr_output_type = 'pdfa'
  $paperless_ocr_pages = '0'
  $paperless_ocr_image_dpi = ''
  # see https =//ocrmypdf.readthedocs.io/en/latest/api.html#ocrmypdf.ocr
  $paperless_ocr_user_args = '"optimize" = 1'
  $paperless_use_jbig2enc = 'True'
  $paperless_big2enc_lossy = 'False'

  # Tika settings
  $paperless_tika_enabled = 'False'
  $paperless_tika_endpoint = "http://localhost:9998"
  $paperless_tika_gotenberg_endpoint = "http://localhost:3000"

  # Software tweaks
  $paperless_time_zone = 'Europe/Berlin'
  $paperless_consumer_polling ='0'
  $paperless_consumer_delete_duplicates = 'False'
  $paperless_consumer_recursive = 'False'
  $paperless_consumer_subdirs_as_tags = 'False'
  $paperless_convert_memory_limit = '0'
  $paperless_convert_tmpdir = ''
  $paperless_optimize_thumbnails = 'True'
  $paperless_pre_consume_script = ''
  $paperless_post_consume_script = ''
  $paperless_filename_date_order = ''
  $paperless_thumbnail_font_name = '/usr/share/fonts/liberation/LiberationSerif-Regular.ttf'
  $paperless_ignore_dates = ''

  # Superuser settings
  $paperless_superuser_name = 'paperlessngx'
  $paperless_superuser_email = 'paperlessngx@example.com'
  $paperless_superuser_password = 'paperlessngx'

  # System user settings
  $paperless_system_user    = 'paperlessngx'
  $paperless_system_group   = 'paperlessngx'

  # Webserver settings
  $paperless_listen_address = '127.0.0.1'
#  $paperless_listen_address = '172.16.10.238'
  $paperless_listen_port    = '8000'


  $paperless_package_name = [
    'python3-pip',
    'python3-dev',
    'python3-virtualenv',
    'fonts-liberation',
    'imagemagick',
    'optipng',
    'gnupg',
    'libpq-dev',
    'libmagic-dev',
    'mime-support',
    'libzbar0',
    'poppler-utils',
  ]

  $ocrmypdf_package_name = [
    'unpaper',
    'ghostscript',
    'icc-profiles-free',
    'qpdf',
    'liblept5',
    'libxml2',
    'pngquant',
    'zlib1g',
    'tesseract-ocr',
#    'tesseract-ocr-deu',
  ]

  ## not used at the moment
  $dev_package_name = [
    'sudo',
    'build-essential',
    'python3-setuptools',
    'python3-wheel',
  ]


  $redis_package_name = [
    'redis-server',
  ]

}
