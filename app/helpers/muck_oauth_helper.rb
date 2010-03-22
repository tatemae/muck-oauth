module MuckOauthHelper
  
  # Generates a javascript array of emails from gmail.  Values will be
  # put into a variable named 'gmail_contacts'
  def gmail_contacts_for_auto_complete(user)
    return unless user.google
    contacts = user.google.portable_contacts.all.collect do |contact|
      contact["emails"].collect{ |email| "'#{email['value']}'" }
    end.flatten
    "var gmail_contacts = [#{contacts.join(',')}];"
  end
  
  # Renders fancybox javascript for oauth services
  def oauth_fancybox_scripts
    render :partial => 'oauth_consumers/oauth_fancybox_scripts'
  end

  # Render a list of a user's current oauth services.
  # user:           User for which to render services
  # include_icons:  If true this will render an iconf for the service  
  def oauth_current_services(user, include_icons = true)
    render :partial => 'oauth_consumers/oauth_current_services', :locals => { :consumer_tokens => oauth_consumer_tokens(user), :include_icons => include_icons }
  end
  
  # Render a list of all available oauth services.
  # include_icons: If true this will render an iconf for the service
  def oauth_available_services(user = nil, include_icons = true)
    render :partial => 'oauth_consumers/oauth_available_services', :locals => { :services => oauth_services(user), :include_icons => include_icons }
  end
  
  # Gets an caches the given user's oauth tokens
  def oauth_consumer_tokens(user)
    if user.blank?
      @all_oauth_consumer_tokens ||= ConsumerToken.all
    else
      @oauth_consumer_tokens ||= ConsumerToken.all(:conditions => { :user_id => user.id })
    end
  end
  
  # Gets and caches all services.  
  # user:     If user is specified then the given user's current oauth services will be excluded from 
  #           the returned list of services.
  def oauth_services(user = nil)
    @oauth_services ||= OAUTH_CREDENTIALS.keys-oauth_consumer_tokens(user).collect{ |c| c.class.service_name }
  end
  
  def oauth_service_name(service_name)
    name = service_name.to_s.humanize
    name = 'Fire Eagle' if name == 'Fireeagle'
    name = 'LinkedIn' if name == 'Linkedin' 
    name = 'FriendFeed' if name == 'Friendfeed' 
    name
  end
  
end