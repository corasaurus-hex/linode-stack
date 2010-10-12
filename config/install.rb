STACK_PATH = File.join(File.dirname(__FILE__), "..")

Dir.glob(File.join(STACK_PATH, "sprinkle", "**", "*.rb")).each do |lib|
  require lib
end

Dir.glob(File.join(STACK_PATH, "packages", "*.rb")).each do |lib|
  require lib
end

$:<< File.join(STACK_PATH, "sprinkle")

policy :all, :roles => :app do
  requires :user
  requires :system_upgrade
  requires :ntp
  requires :build_essential
  requires :git
  requires :redis
  requires :ruby_enterprise
  requires :god
  requires :tools
  requires :apache
  requires :passenger
  requires :gems
  requires :app_configs
  requires :logrotate
end

deployment do
  delivery :capistrano do
    begin
      recipes "Capfile"
    rescue LoadError
      recipes "deploy"
    end
  end
end


begin
  gem "sprinkle", ">= 0.3.1"
rescue Gem::LoadError
  puts "sprinkle 0.3.1 required.\n Run: `gem install sprinkle`"
  exit
end
