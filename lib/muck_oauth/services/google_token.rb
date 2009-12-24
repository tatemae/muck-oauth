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
  # GET http://www.google.com/m8/feeds/contacts/default/base
  # limit
  def contacts(limit = 10000)
    convert_google_contacts_json_to_users(load_contacts(limit))
  end

  # Loads contacts using Google api and OAuth token.
  def load_contacts(limit = 10000)
    path = "http://www.google.com/m8/feeds/contacts/default/full?max-results=#{limit}&alt=json"
    request_path(path)
  end
  
  # Converts json returned from google into a feed object
  def convert_google_contacts_json_to_users(json)
    if json['responseStatus'] == 200
      if json['responseData']['feed']['entries']
        json['responseData']['feed']['entries'].collect do |entry|
          first_name, last_name = parse_name(entry['gd:name'])
          OpenStruct.new( { :email => entry['gd:email'],
                            :first_name => first_name,
                            :last_name => last_name } )
        end
      end
    end
  end
  
  # Loads a user's groups using Google api and OAuth token.
  def load_groups(limit = 10000)
    path = "http://www.google.com/m8/feeds/groups/default/full?max-results=#{limit}&alt=json"
    request_path(path)
  end
  
  def request_path(path)
    request = GoogleToken.consumer.create_signed_request(:get, path, self, { :scheme => :header })
    uri = URI.parse(path)
    http = Net::HTTP.new(uri.host, uri.port)
    response = http.request(request)
    if response.code == '200'
      JSON.parse(response.body)
    else
      raise MuckOauth::Exceptions::HTTPResultError, I18n.t('muck.oauth.http_result_error', error => response.to_s)
    end
  end
  
end
