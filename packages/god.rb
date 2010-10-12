package :god do

  requires :ruby_enterprise, :god_gem, :god_config

end

package :god_gem do

  gem 'god'

  transfer 'resources/god/god', '/root/god', :sudo => true do
    post :install, 'sudo mv -f ~/god /etc/init.d/god'
    post :install, 'sudo chmod +x /etc/init.d/god'
    post :install, 'sudo mkdir -p /var/log/god && chown deploy:deploy /var/log/god'
    post :install, 'sudo update-rc.d god defaults'
    post :install, 'sudo /etc/init.d/god start'
  end

  verify do
    has_gem 'god'
    has_file '/etc/init.d/god'
  end

end


package :god_config do

  transfer 'resources/god/main', '/root/main', :sudo => true do
    pre :install, 'sudo mkdir -p /etc/god/conf'
    post :install, 'sudo mv -f ~/main /etc/god/main'
  end

end
