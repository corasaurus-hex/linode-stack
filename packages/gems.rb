package :gems do

  requires :ruby_enterprise

  gem 'bundler'
  gem 'whenever'
  apt "libcurl3", "libcurl3-gnutls", "libcurl4-openssl-dev", "libxml2", "libxml2-dev", "libxslt1-dev"

  verify do
    has_gem 'bundler'
    has_gem 'whenever'
    has_dpkg "libcurl3", "libcurl3-gnutls", "libcurl4-openssl-dev", "libxml2", "libxml2-dev", "libxslt1-dev"
  end

end
