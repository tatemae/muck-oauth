require 'linkedin'

class LinkedinToken < ConsumerToken
  LINKEDIN_SETTINGS={
    :site => "https://api.linkedin.com", 
    :request_token_path => "/uas/oauth/requestToken",
    :access_token_path  => "/uas/oauth/accessToken",
    :authorize_path     => "/uas/oauth/authorize"
  }
  
  def self.consumer
    @consumer ||= create_consumer
  end 
  
  def self.create_consumer(options={})
    OAuth::Consumer.new(credentials[:key], credentials[:secret], LINKEDIN_SETTINGS.merge(options))
  end
    
  def self.get_request_token(callback_url, scope = nil)
    consumer.get_request_token({ :oauth_callback => callback_url })
  end
  
  def client
    unless @client
      @client = LinkedIn::Client.new(LinkedInToken.consumer.key, LinkedInToken.consumer.secret)
      @client.authorize_from_access(token, secret)
    end 
    @client
  end
  
end