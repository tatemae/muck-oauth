require 'muck_oauth/services/friendfeed_token'
require 'muck_oauth/services/google_token'
require 'muck_oauth/services/linkedin_token'
require 'muck_oauth/services/yahoo_token'

ActionController::Base.send :helper, MuckOauthHelper

ActiveRecord::Base.class_eval { include ActiveRecord::Acts::MuckOauthUser }

I18n.load_path += Dir[ File.join(File.dirname(__FILE__), '..', 'locales', '*.{rb,yml}') ]
