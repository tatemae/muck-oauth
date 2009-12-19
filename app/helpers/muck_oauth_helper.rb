module MuckOauthHelper
  
  def oauth_current_services
    consumer_tokens = ConsumerToken.all(:conditions => { :user_id => current_user.id })
    render :partial => 'oauth_consumers/oauth_current_services', :locals => { :consumer_tokens => consumer_tokens }
  end
  
  def oauth_available_services
    services = OAUTH_CREDENTIALS.keys-@consumer_tokens.collect{ |c| c.class.service_name }
    render :partial => 'oauth_consumers/oauth_available_services', :locals => { :services => services }
  end
  
end