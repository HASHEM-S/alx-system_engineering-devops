#!/usr/bin/pup
# Install a specific version of flask (2.1.0)
exec { 'install_flask':
  command     => '/usr/bin/pip3 install Flask==2.1.0',
  path        => ['/usr/bin', '/usr/local/bin'],
  logoutput   => true,
  unless      => '/usr/bin/pip3 show Flask | grep -q "Version: 2.1.0"',
}
