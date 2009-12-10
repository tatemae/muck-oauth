require 'rake'
require 'rake/tasklib'
require 'fileutils'

module MuckOauth
  class Tasks < ::Rake::TaskLib
    def initialize
      define
    end
  
    private
    def define
      
      namespace :muck do
        namespace :oauth do
          desc "Sync required files from muck oauth."
          task :sync do
            path = File.join(File.dirname(__FILE__), *%w[.. ..])
            system "rsync -ruv #{path}/db ."
            system "rsync -ruv #{path}/public ."
            system "rsync -ruv #{path}/config/initializers ./config"
          end
        end
      end

    end
  end
end
MuckOauth::Tasks.new