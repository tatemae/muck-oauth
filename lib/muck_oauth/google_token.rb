class GoogleToken

  # GET http://www.google.com/m8/feeds/contacts/default/base
  # OAuth::Consumer
  # limit
  def contacts(limit = 10000)
    convert_google_contacts_json_to_users(load_contacts(oauth_consumer, limit))
  end

  def load_contacts(limit = 10000)
    #http://www.google.com/m8/feeds/contacts/default/full
    #http://www.google.com/m8/feeds/contacts/default/base
    get('http://www.google.com/m8/feeds/contacts/default/full',
          :query => { 'max-results' => limit } )
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
  
  #
  # Overlord::GoogleContacts.validate_token(user.google.token)
  def validate_token
    get('https://www.google.com/accounts/AuthSubTokenInfo', authorization_header(token))
  end
  
end
