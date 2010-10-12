package :redis do

  description "Redis."
  version "1.2.0"
  requires :god, :redis_monitor

  apt "redis-server"

  verify do
    has_executable "/usr/bin/redis-server"
  end

end


package :redis_monitor do

  transfer 'resources/god/redis', '/root/redis', :sudo => true do
    pre :install, 'sudo mkdir -p /etc/god/conf'
    post :install, 'sudo mv -f ~/redis /etc/god/conf/redis'
  end

end
