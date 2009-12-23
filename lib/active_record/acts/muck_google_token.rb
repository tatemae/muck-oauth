require 'portablecontacts'

module ActiveRecord
  module Acts #:nodoc:
    module MuckGoogleToken # :nodoc:

      def self.included(base)
        base.extend(ClassMethods)
      end
  
      module ClassMethods
        
        # +acts_as_muck_google_token+
        def acts_as_muck_google_token
          include ActiveRecord::Acts::MuckGoogleToken::InstanceMethods
          extend ActiveRecord::Acts::MuckGoogleToken::SingletonMethods
        end
      end

      # class methods
      module SingletonMethods
        
        GOOGLE_SETTINGS={
          :site=>"https://www.google.com", 
          :request_token_path => "/accounts/OAuthGetRequestToken",
          :authorize_path => "/accounts/OAuthAuthorizeToken",
          :access_token_path => "/accounts/OAuthGetAccessToken",
        }

        def consumer
          @consumer||=create_consumer
        end 

        def create_consumer(options={})
          OAuth::Consumer.new credentials[:key],credentials[:secret],GOOGLE_SETTINGS.merge(options)
        end

        def get_request_token(callback_url, scope=nil)
          consumer.get_request_token({:oauth_callback=>callback_url}, :scope=>scope||credentials[:scope]||"http://www-opensocial.googleusercontent.com/api/people")
        end

      end
      
      module InstanceMethods
       
        def portable_contacts
          @portable_contacts||= PortableContacts::Client.new "http://www-opensocial.googleusercontent.com/api/people", client
        end

        # Gets and parses contacts from google into objects.
        # GET http://www.google.com/m8/feeds/contacts/default/base
        # limit
        def contacts(limit = 10000)
          convert_google_contacts_json_to_users(load_contacts(limit))
        end

        def load_contacts(limit = 10000)
          #http://www.google.com/m8/feeds/contacts/default/full
          #http://www.google.com/m8/feeds/contacts/default/base
          uri = client.create_signed_request(:get, "http://www.google.com/m8/feeds/contacts/default/full?max-results=#{limit}", token, { :scheme => :query_string })
          get(uri)
        end

        # Converts json returned from google into a feed object
        def convert_google_contacts_json_to_users(json)
          if json['responseStatus'] == 200
            if json['responseData']['feed']['entries']
              json['responseData']['feed']['entries'].collect do |entry|
                first_name, last_name = parse_name(entry['gd:name'])
                OpenStruct.new( { :email => entry['gd:email'],
                                  :first_name => first_name,
                                  :last_name => last_name } )
              end
            end
          end
        end

        #
        # Overlord::GoogleContacts.validate_token(user.google.token)
        def validate_token
          uri = client.create_signed_request(:get, 'https://www.google.com/accounts/AuthSubTokenInfo', token)
          get(uri)
        end
        
      end
      
    end
  end
end