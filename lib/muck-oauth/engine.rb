require 'muck-oauth'
require 'rails'

module MuckProfiles
  class Engine < ::Rails::Engine
    
    def muck_name
      'muck-oauth'
    end
    
    initializer 'muck-oauth.helpers' do |app|
      ActiveSupport.on_load(:action_view) do
        include MuckOauthHelper
      end
    end
    
    initializer 'muck-oauth.i18n' do |app|
      ActiveSupport.on_load(:i18n) do
        I18n.load_path += Dir[ File.join(File.dirname(__FILE__), '..', '..', 'config', 'locales', '*.{rb,yml}') ]
      end
    end
        
  end
end