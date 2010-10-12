package :git do

  description "Git core."

  apt "git-core"

  verify do
    has_executable "/usr/bin/git"
  end

end
