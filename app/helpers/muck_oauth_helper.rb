module MuckOauthHelper
  
  def oauth_fancybox_scripts
    render :partial => 'oauth_consumers/oauth_fancybox_scripts'
  end
  
  def oauth_current_services
    render :partial => 'oauth_consumers/oauth_current_services', :locals => { :consumer_tokens => oauth_consumer_tokens }
  end
  
  def oauth_available_services
    render :partial => 'oauth_consumers/oauth_available_services', :locals => { :services => oauth_services }
  end
  
  def oauth_consumer_tokens
    @oauth_consumer_tokens ||= ConsumerToken.all(:conditions => { :user_id => current_user.id })
  end
  
  def oauth_services
    @oauth_services ||= OAUTH_CREDENTIALS.keys-oauth_consumer_tokens.collect{ |c| c.class.service_name }
  end
  
end