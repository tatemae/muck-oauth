ActionController::Base.send :helper, MuckOauthHelper

ActiveRecord::Base.class_eval { include ActiveRecord::Acts::MuckOauthUser }
ActiveRecord::Base.class_eval { include ActiveRecord::Acts::MuckFriendfeedToken }
ActiveRecord::Base.class_eval { include ActiveRecord::Acts::MuckGoogleToken }
ActiveRecord::Base.class_eval { include ActiveRecord::Acts::MuckLinkedinToken }
ActiveRecord::Base.class_eval { include ActiveRecord::Acts::MuckYahooToken }

I18n.load_path += Dir[ File.join(File.dirname(__FILE__), '..', 'locales', '*.{rb,yml}') ]
