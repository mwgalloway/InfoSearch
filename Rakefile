require 'rake'
require 'resque/tasks'

require ::File.expand_path('../config/environment', __FILE__)

require 'active_support/core_ext'

desc 'Start IRB with application environment loaded'
task "console" do
  exec "irb -r./config/environment"
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

task :default  => :spec
