begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  desc 'Default task'
  task :default => :spec
  rescue LoadError
  # no rspec available
end
