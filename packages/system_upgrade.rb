package :system_upgrade do

  description "Upgrade the system"

  noop do
    post :install, "env DEBIAN_FRONTEND=noninteractive apt-get -y update"
    post :install, "env DEBIAN_FRONTEND=noninteractive apt-get -y upgrade"
  end

end
