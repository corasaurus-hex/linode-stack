package :app_configs do

  description "Various and general server configuration"
  requires :user

  transfer 'resources/config', '/root', :recursive => true do
    pre :install, 'sudo mkdir -p /data/CHANGEME/shared/config'
    post :install, 'sudo mv -f ~/config/* /data/CHANGEME/shared/config'
    post :install, 'sudo rm -rf ~/config'
    post :install, 'sudo chown -R deploy:deploy /data/CHANGEME'
  end

  transfer 'resources/config/application.yml', '/root/application.yml', :sudo => true, :render => true, :locals => { :rails_env => ENV["RAILS_ENV"] } do
    pre :install, 'sudo mkdir -p /data/CHANGEME/shared/config'
    post :install, 'sudo mv -f ~/application.yml /data/CHANGEME/shared/config'
    post :install, 'sudo chown -R deploy:deploy /data/CHANGEME'
  end

end
