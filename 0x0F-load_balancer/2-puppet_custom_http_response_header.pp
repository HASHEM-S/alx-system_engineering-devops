# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Define custom HTTP header configuration
file { '/etc/nginx/sites-available/custom_header':
  ensure  => present,
  content => "server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name _;

    location / {
        add_header X-Served-By $hostname;
        # Other Nginx configuration directives can go here if needed
    }
}",
  notify  => Service['nginx'],
}

# Create symbolic link to enable the custom header configuration
file { '/etc/nginx/sites-enabled/custom_header':
  ensure => link,
  target => '/etc/nginx/sites-available/custom_header',
  notify => Service['nginx'],
}

# Ensure Nginx service is running
service { 'nginx':
  ensure => running,
  enable => true,
}
