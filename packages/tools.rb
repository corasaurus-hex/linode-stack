package :tools do

  packages = %w{ tmux htop dstat sysstat ifstat }
  apt *packages

  apt 'ack-grep' do
    post :install, 'sudo ln -sf /usr/bin/ack-grep /usr/local/bin/ack'
  end

  verify do
    has_dpkg *packages
    has_dpkg 'ack-grep'
    has_symlink "/usr/local/bin/ack", "/usr/bin/ack-grep"
  end

end
