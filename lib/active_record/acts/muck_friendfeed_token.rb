module ActiveRecord
  module Acts #:nodoc:
    module MuckFriendfeedToken # :nodoc:

      def self.included(base)
        base.extend(ClassMethods)
      end
  
      module ClassMethods
        
        # +acts_as_muck_friend_feed_token+
        # Add a friendfeed token class to your project:
        # class FriendfeedToken < ConsumerToken 
        #   acts_as_muck_friend_feed_token
        # end
        def acts_as_muck_friendfeed_token
          include ActiveRecord::Acts::MuckFriendfeedToken::InstanceMethods
          extend ActiveRecord::Acts::MuckFriendfeedToken::SingletonMethods
        end
      end

      # class methods
      module SingletonMethods
        
        FRIENDFEED_SETTINGS = { 
          :site => "https://friendfeed.com", 
          :request_token_path => "/account/oauth/request_token", 
          :authorize_path => "/account/oauth/authorize", 
          :access_token_path => "/account/oauth/access_token", 
        }
        
        def consumer 
          @consumer ||= create_consumer 
        end

        def create_consumer(options={}) 
          OAuth::Consumer.new credentials[:key], credentials[:secret], FRIENDFEED_SETTINGS.merge(options)
        end 

        def get_request_token(callback_url) 
          consumer.get_request_token({ :oauth_callback => callback_url })
        end

      end
      
      module InstanceMethods
       
        
      end
      
    end
  end
end