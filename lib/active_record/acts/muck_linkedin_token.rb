require 'linkedin'

module ActiveRecord
  module Acts #:nodoc:
    module MuckLinkedinToken # :nodoc:

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
          include ActiveRecord::Acts::MuckLinkedinToken::InstanceMethods
          extend ActiveRecord::Acts::MuckLinkedinToken::SingletonMethods
        end
      end

      # class methods
      module SingletonMethods
        
        LINKEDIN_SETTINGS={
          :site => "https://api.linkedin.com", 
          :request_token_path => "/uas/oauth/requestToken",
          :access_token_path  => "/uas/oauth/accessToken",
          :authorize_path     => "/uas/oauth/authorize"
        }

        def consumer
          @consumer ||= create_consumer
        end 

        def create_consumer(options={})
          OAuth::Consumer.new(credentials[:key], credentials[:secret], LINKEDIN_SETTINGS.merge(options))
        end

        def get_request_token(callback_url)
          consumer.get_request_token({ :oauth_callback => callback_url })
        end

      end
      
      module InstanceMethods

        def client
          unless @client
            @client = ::LinkedIn::Client.new(LinkedinToken.consumer.key, LinkedinToken.consumer.secret)
            @client.authorize_from_access(token, secret)
          end 
          @client
        end

      end
      
    end
  end
end