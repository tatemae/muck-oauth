ActiveSupport::Dependencies.load_once_paths << lib_path # disable reloading of this plugin

require 'muck_oauth'
require 'muck_oauth/initialize_routes'
