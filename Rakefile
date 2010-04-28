require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test
task :test => :check_dependencies

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "muck-oauth"
    gem.summary = %Q{OAuth for muck}
    gem.description = %Q{A simple wrapper for the oauth and oauth-plugin gems so that it is faster to include oauth in muck based applications.}
    gem.email = "justin@tatemae.com"
    gem.homepage = "http://github.com/tatemae/muck-oauth"
    gem.authors = ["Justin Ball"]
    gem.add_dependency "oauth"
    gem.add_dependency "oauth-plugin"
    gem.add_dependency "twitter"
    gem.add_dependency "portablecontacts"
    gem.add_dependency "agree2"
    gem.add_dependency "fireeagle"
    gem.add_dependency "linkedin"
    gem.add_dependency "overlord"
    gem.add_dependency "muck-engine"
    gem.add_dependency "muck-users"
    gem.add_development_dependency "babelphish"
    gem.add_development_dependency "shoulda"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test/rails_root/test'
  t.pattern = 'test/rails_root/test/**/*_test.rb'
  t.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |t|
    #t.libs << 'lib'
    t.libs << 'test/rails_root/lib'
    t.pattern = 'test/rails_root/test/**/*_test.rb'
    t.verbose = true
    t.output_dir = 'coverage'
    t.rcov_opts << '--exclude "gems/*"'
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

require 'rake/rdoctask'
desc 'Generate documentation for the muck-oauth gem.'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "muck_oauth #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Translate this gem'
task :translate do
  file = File.join(File.dirname(__FILE__), 'locales', 'en.yml')
  system("babelphish -o -y #{file}")
end