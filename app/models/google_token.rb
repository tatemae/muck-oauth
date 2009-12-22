require 'portablecontacts'
require 'net/http'
require 'rexml/document'

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
    OAuth::Consumer.new credentials[:key],credentials[:secret],GOOGLE_SETTINGS.merge(options)
  end
    
  def self.get_request_token(callback_url, scope=nil)
    consumer.get_request_token({:oauth_callback=>callback_url}, :scope=>scope||credentials[:scope]||"http://www-opensocial.googleusercontent.com/api/people")
  end
  
  def portable_contacts
    @portable_contacts||= PortableContacts::Client.new "http://www-opensocial.googleusercontent.com/api/people", client
  end

  # GET http://www.google.com/m8/feeds/contacts/default/base
  def contacts(limit = 10000)
    http = Net::HTTP.new('www.google.com', 80)
    # by default Google returns 50? contacts at a time.  Set max-results to very high number
    # in order to retrieve more contacts
    path = "/m8/feeds/contacts/default/base?max-results=10000"
    headers = {'Authorization' => "AuthSubtoken="#{token}""}
    resp, data = http.get(path, headers)
debugger
    # extract the name and email address from the response data
    xml = REXML::Document.new(data)
    contacts = []
    xml.elements.each('//entry') do |entry|
      person = {}
      person['name'] = entry.elements['title'].text

      gd_email = entry.elements['gd:email']
      person['email'] = gd_email.attributes['address'] if gd_email

      contacts << person
    end
  end
  
end