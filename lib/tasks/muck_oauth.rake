require 'fileutils'

namespace :muck do
  namespace :sync do
    desc "Sync required files from muck oauth."
    task :oauth do
      path = File.join(File.dirname(__FILE__), *%w[.. ..])
      system "rsync -ruv #{path}/db ."
      #system "rsync -ruv #{path}/public ."
      if !File.exists?('./config/initializers/oauth_consumers.rb')
        system "rsync -ruv #{path}/config/initializers/oauth_consumers.rb ./config/initializers/oauth_consumers.rb"
      end
    end
  end
end