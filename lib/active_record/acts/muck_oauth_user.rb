module ActiveRecord
  module Acts #:nodoc:
    module MuckOauthUser # :nodoc:

      def self.included(base)
        base.extend(ClassMethods)
      end
  
      module ClassMethods
        
        # +acts_as_muck_oauth_user+ adds Oauth capabilities to a user.  Currently, muck-oauth supports the following services:
        # twitter
        # google
        # linkedin
        # yahoo
        # fire_eagle
        # flickr
        # friend_feed
        # After adding this method to a user you will be able to call methods against these services ie:
        # user.linked_in.client.profile
        def acts_as_muck_oauth_user
          
          has_many :client_applications
          has_many :tokens, :class_name => "OauthToken", :order => "authorized_at desc", :include => [:client_application]
                    
          has_one  :twitter, :class_name => "TwitterToken", :dependent => :destroy
          has_one  :google, :class_name => "GoogleToken", :dependent => :destroy
          has_one  :linked_in, :class_name => "LinkedinToken", :dependent => :destroy
          has_one  :yahoo, :class_name => "YahooToken", :dependent => :destroy
          has_one  :fire_eagle, :class_name => "FireeagleToken", :dependent => :destroy
          has_one  :flickr, :class_name => "FlickrToken", :dependent => :destroy
          has_one  :friend_feed, :class_name => "FriendfeedToken", :dependent => :destroy
          
          include ActiveRecord::Acts::MuckOauthUser::InstanceMethods
          extend ActiveRecord::Acts::MuckOauthUser::SingletonMethods
        end
      end

      # class methods
      module SingletonMethods
      end
      
      module InstanceMethods
       
      end
      
    end
  end
end