package :postgres do

  description "Postgres server."
  requires :build_essential, :postgres_server, :postgres_password

end

package :postgres_server do

  apt "postgresql"

  verify do
    has_dpkg "postgresql"
  end

end

package :postgres_gem do

  requires :postgres_server, :ruby_enterprise

  gem "pg"

  verify do
    has_gem "pg"
  end

end

require 'yaml'

package :postgres_password do

  config = YAML.load_file(File.dirname(__FILE__) + '/../resources/config/database.yml')['production']

  noop do
    post :install, %{su - postgres sh -c "psql -c '\\du' | grep -q '#{config['username']}' || psql -c \\"create user #{config['username']} with encrypted password '#{config['password']}'\\""}
    post :install, %{su - postgres sh -c "psql -c '\\l' | grep -q '#{config['database']}' || createdb #{config['database']}"}
    post :install, %{su - postgres sh -c "psql -c 'grant all on database \\"#{config['database']}\\" to #{config['username']}'"}
    post :install, %{su - postgres sh -c "psql #{config['database']} -c 'ALTER SCHEMA public OWNER TO #{config['username']}'"}
  end

end
