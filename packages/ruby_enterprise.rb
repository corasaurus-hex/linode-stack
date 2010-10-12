package :ruby_enterprise do

  description "Ruby Enterprise Edition."
  requires :build_essential

  deb "http://rubyforge.org/frs/download.php/71098/ruby-enterprise_1.8.7-2010.02_amd64_ubuntu10.04.deb"

  apt 'libreadline-ruby'

  verify do
    has_executable "/usr/local/bin/ruby"
  end

end
