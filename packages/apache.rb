package :apache do

  description "Apache2 web server."

  apt "apache2 apache2.2-common apache2-mpm-prefork apache2-utils libexpat1 ssl-cert apache2-prefork-dev"

  verify do
    has_executable "/usr/sbin/apache2"
  end

end
