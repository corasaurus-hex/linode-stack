package :logrotate do

  transfer 'resources/logrotate', '/root', :recursive => true do
    post :install, 'sudo mv -f ~/logrotate/* /etc/logrotate.d'
    post :install, 'sudo rm -rf ~/logrotate'
    post :install, 'sudo chown root:root /etc/logrotate.d/*'
    post :install, 'sudo chmod 644 /etc/logrotate.d/*'
  end

end
