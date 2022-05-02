# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include paperless_ngx::install
class paperless_ngx::install inherits paperless_ngx {

  exec { "create paperlessngx venv":
    command => "python3 -m virtualenv ${paperless_virtualenv} -p /usr/bin/python3",
    unless  => "test -d ${paperless_virtualenv}", 
    user    => $paperless_system_user, 
  }  
  exec { "install paperlessng requirements":
    command     => "${paperless_virtualenv}/bin/pip3 install -r ${paperless_directory}/requirements.txt",
    user        => $paperless_system_user,
    logoutput   => true,
    refreshonly => true,
    subscribe   => Exec['create paperlessngx venv']
  } 
  exec { "migrate database schema":
    command   => "${paperless_virtualenv}/bin/python3 ${paperless_directory}/src/manage.py migrate",
    user      => $paperless_system_user,
    logoutput => true,
    refreshonly => true,
    subscribe   => Exec['create paperlessngx venv']

  }


  ## "manage.py createsuperuser" only works on interactive TTYs
  $creation_script = @("EOT"/L) 
    from django.contrib.auth.models import User
    from django.contrib.auth.hashers import get_hasher
    if User.objects.filter(username='${ paperless_superuser_name }').exists():
      user = User.objects.get(username='${ paperless_superuser_name }')
      old = user.__dict__.copy()
      user.is_superuser = True
      user.email = '${ paperless_superuser_email }'
      user.set_password('${ paperless_superuser_password }')
      user.save()
      new = user.__dict__
      algorithm, iterations, old_salt, old_hash = old['password'].split('$')
      new_password_old_salt = get_hasher(algorithm).encode(password='${ paperless_superuser_password }', salt=old_salt, iterations=int(iterations))
      _, _, _, new_hash = new_password_old_salt.split('$')
      if not (old_hash == new_hash and old['is_superuser'] == new['is_superuser'] and old['email'] == new['email']):
        print('changed')
      else:
        User.objects.create_superuser('${ paperless_superuser_name }', '${ paperless_superuser_email }', '${ paperless_superuser_password }')
        print('changed')
      | EOT

  exec { "configure paperless superuser":
    command   => "${paperless_virtualenv}/bin/python3 ${paperless_directory}/src/manage.py shell -c \"${creation_script}\"",
    user      => $paperless_system_user,
    refreshonly => true,
    subscribe   => Exec['create paperlessngx venv']
  }
 



}
