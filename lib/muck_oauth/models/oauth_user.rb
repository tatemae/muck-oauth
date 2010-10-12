# include MuckOauth::Models::MuckUser
module MuckOauth
  module Models
    module MuckUser

      extend ActiveSupport::Concern
      
      included do

        # +include MuckOauth::Models::MuckUser+ adds Oauth capabilities to a user.  Currently, muck-oauth supports the following services:
        # twitter
        # google
        # linkedin
        # yahoo
        # fire_eagle
        # flickr
        # friend_feed
        # After adding this method to a user you will be able to call methods against these services ie:
        # user.linked_in.client.profile
        has_many :client_applications
        has_many :tokens, :class_name => "OauthToken", :order => "authorized_at desc", :include => [:client_application], :dependent => :destroy

        has_one  :twitter, :class_name => "TwitterToken"
        has_one  :google, :class_name => "GoogleToken"
        has_one  :linked_in, :class_name => "LinkedinToken"
        has_one  :yahoo, :class_name => "YahooToken"
        has_one  :fire_eagle, :class_name => "FireeagleToken"
        has_one  :flickr, :class_name => "FlickrToken"
        has_one  :friend_feed, :class_name => "FriendfeedToken"

      end
      
    end
  end
end