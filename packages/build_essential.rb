package :build_essential do

  description "Build tools."

  requires :system_upgrade

  apt "build-essential"

  verify do
    has_dpkg "build-essential"
  end

end
