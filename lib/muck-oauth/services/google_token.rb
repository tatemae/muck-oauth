require 'portablecontacts'

class GoogleToken < ConsumerToken
  
  GOOGLE_SETTINGS={
    :site=>"https://www.google.com", 
    :request_token_path => "/accounts/OAuthGetRequestToken",
    :authorize_path => "/accounts/OAuthAuthorizeToken",
    :access_token_path => "/accounts/OAuthGetAccessToken",
  }
  
  def self.consumer
    @consumer||=create_consumer
  end 
  
  def self.create_consumer(options={})
    OAuth::Consumer.new credentials[:key], credentials[:secret], GOOGLE_SETTINGS.merge(options)
  end
    
  def self.get_request_token(callback_url, scope=nil)
    consumer.get_request_token({:oauth_callback=>callback_url}, :scope=>scope||credentials[:scope]||"http://www-opensocial.googleusercontent.com/api/people")
  end
  
  def portable_contacts
    @portable_contacts||= PortableContacts::Client.new "http://www-opensocial.googleusercontent.com/api/people", client
  end
  
  # Gets and parses contacts from google into objects.
  # limit: Maximum number of contacts to retrieve
  def contacts(limit = 10000)
    convert_google_contacts_json_to_users(load_contacts(limit))
  end

  # Loads contacts using Google api and OAuth token.
  def load_contacts(limit = 10000)
    get("http://www.google.com/m8/feeds/contacts/default/full?max-results=#{limit}")
  end
  
  # Converts json returned from google into a feed object
  def convert_google_contacts_json_to_users(json)
    if json['feed'] && json['feed']['entry']
      json['feed']['entry'].collect do |entry|
        emails = entry['gd$email'].collect { |gd| gd['address'] } if entry['gd$email']
        phones = entry['gd$phoneNumber'].collect { |gd| gd['t'] } if entry['gd$phoneNumber']
        if entry['gd$name']
          first_name = entry['gd$name']['gd$givenName'] if entry['gd$name']['gd$givenName']
          last_name = entry['gd$name']['gd$familyName'] if entry['gd$name']['gd$familyName']
        end
        OpenStruct.new( { :emails => emails,
                          :phones => phones,
                          :first_name => first_name,
                          :last_name => last_name } )
      end
    end
  end
  
  # Loads a user's groups using Google api and OAuth token.
  def load_groups(limit = 10000)
    get("http://www.google.com/m8/feeds/groups/default/full?max-results=#{limit}")
  end
  
  def get(path)
    response = self.client.get(path + "&alt=json&v=3.0")
    if response.code == '200'
      JSON.parse(response.body)
    else
      raise MuckOauth::Exceptions::HTTPResultError, I18n.t('muck.oauth.http_result_error', :error => response.to_s)
    end
  end
  
end
