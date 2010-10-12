package :passenger do

  requires :apache, :ruby_enterprise, :passenger_module, :passenger_config, :apache_config

end


package :passenger_module do

  description "Phusion Passenger (mod_rails)."
  version "2.2.15"

  requires :apache, :ruby_enterprise

  apt "libapr1-dev libaprutil1-dev"

  gem "passenger", :version => version do
    post :install, %{sudo passenger-install-apache2-module --auto}
    post :install, "sudo mkdir -p /etc/apache2/extras"
    post :install, "sudo touch /etc/apache2/extras/passenger.conf"
    post :install, %{echo "Include /etc/apache2/extras/passenger.conf" | sudo tee -a /etc/apache2/apache2.conf}
  end

  verify do
    has_file "/etc/apache2/extras/passenger.conf"
    has_file "/usr/local/lib/ruby/gems/1.8/gems/passenger-#{version}/ext/apache2/mod_passenger.so"
  end

end


package :passenger_config do

  requires :apache, :passenger_module
  version "2.2.15"

  transfer 'resources/apache/passenger.conf', '/root/passenger.conf', :render => true, :locals => { :rails_env => ENV["RAILS_ENV"], :version => version } do
    post :install, 'sudo mv -f ~/passenger.conf /etc/apache2/extras/'
  end

end


package :apache_config do

  requires :apache, :passenger_module

  transfer 'resources/apache/site', '/root/site', :render => true, :locals => { :rails_env => ENV["RAILS_ENV"] } do
    post :install, 'sudo mkdir -p /data/CHANGEME/current/public /data/CHANGEME/httpd_logs'
    post :install, 'sudo chown -R deploy:deploy /data'
    post :install, 'sudo mv -f ~/site /etc/apache2/sites-available/CHANGEME'
    post :install, 'sudo a2dissite default'
    post :install, 'sudo a2enmod ssl deflate expires rewrite'
    post :install, 'sudo a2ensite CHANGEME'
    post :install, 'sudo /etc/init.d/apache2 restart'
  end

end
