class FriendfeedToken < ConsumerToken 
  FRIENDFEED_SETTINGS = { 
    :site => "https://friendfeed.com", 
    :request_token_path => "/account/oauth/request_token", 
    :authorize_path => "/account/oauth/authorize", 
    :access_token_path => "/accounts/account/oauth/access_token", 
  } 
  
  def self.consumer 
    @consumer||=create_consumer 
  end
  
  def self.create_consumer(options={}) 
    OAuth::Consumer.new credentials[:key], credentials[:secret], FRIENDFEED_SETTINGS.merge(options)
  end 
  
  def self.get_request_token(callback_url) 
    consumer.get_request_token({ :oauth_callback => callback_url })
  end
  
end