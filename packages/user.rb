package :user do

  requires :create_user

  transfer 'resources/ssh', '/root/ssh', :recursive => true do
    post :install, 'sudo mkdir /home/deploy/.ssh'
    post :install, 'sudo mv -f ~/ssh/* /home/deploy/.ssh'
    post :install, 'sudo ln -s /home/deploy/.ssh/id_rsa_deploy /home/deploy/.ssh/id_rsa'
    post :install, 'sudo ln -s /home/deploy/.ssh/id_rsa_deploy.pub /home/deploy/.ssh/id_rsa.pub'
    post :install, 'sudo chown -R deploy:deploy /home/deploy/.ssh'
    post :install, 'sudo chmod -R 600 /home/deploy/.ssh'
    post :install, 'sudo chmod 700 /home/deploy/.ssh'
    post :install, 'rmdir ~/ssh'
  end

  transfer 'resources/home/profile', '/root/profile', :render => true, :locals => { :rails_env => ENV['RAILS_ENV'] } do
    post :install, 'sudo chown deploy:deploy ~/profile'
    post :install, 'sudo mv -f ~/profile /home/deploy/.profile'
  end

  # Verify purposefully excluded.

end


package :create_user do

  noop do
    post :install, 'sudo useradd -m -s/bin/bash deploy'
  end

  push_text "deploy  ALL=(ALL) NOPASSWD:ALL", '/etc/sudoers', :sudo => true

  verify do
    file_contains '/etc/passwd', 'deploy'
    file_contains '/etc/sudoers', 'deploy'
  end

end
