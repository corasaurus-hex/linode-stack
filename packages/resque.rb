package :resque do

  description "Reque."
  requires :god, :resque_monitor

  gem "resque"

  verify do
    has_executable "/usr/local/bin/resque"
  end

end

package :resque_monitor do

  transfer 'resources/god/resque', '/root/resque', :sudo => true do
    pre :install, 'sudo mkdir -p /etc/god/conf'
    post :install, 'sudo mv -f ~/resque /etc/god/conf/resque'
    post :install, 'sudo mkdir -p /data/CHANGEME/logs'
    post :install, 'sudo chown -R deploy:deploy /data/CHANGEME'
    # If it's running, restart it, if not, start it
    post :install, 'sudo /usr/local/bin/god status && sudo /etc/init.d/god restart || sudo /etc/init.d/god start'
  end

end
