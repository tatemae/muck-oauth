# edit this file to contain credentials for the OAuth services you support.
# each entry needs a corresponding token model.
#
# eg. :twitter => TwitterToken, :hour_feed => HourFeedToken etc.

credentials = {}
credentials[:twitter]   = { :key => Secrets.twitter_oauth_key, 
                            :secret => Secrets.twitter_oauth_secret } if Secrets.twitter_oauth_key
                            
                            # see http://code.google.com/apis/gdata/faq.html#AuthScopes 
credentials[:google]    = { :scope => ["https://mail.google.com/mail/feed/atom/", 
                                       "https://www.google.com/calendar/feeds/",
                                       "https://www.google.com/m8/feeds/",
                                       "http://www-opensocial.googleusercontent.com/api/people"].join(' '),
                            :key => Secrets.google_oauth_key, 
                            :secret => Secrets.google_oauth_secret } if Secrets.google_oauth_key

credentials[:yahoo]     = { :key => Secrets.yahoo_oauth_key, 
                            :secret => Secrets.yahoo_oauth_secret } if Secrets.yahoo_oauth_key

credentials[:flickr]    = { :key => Secrets.flickr_oauth_key, 
                            :secret => Secrets.flickr_oauth_secret } if Secrets.flickr_oauth_key

credentials[:linkedin]  = { :key => Secrets.linkedin_oauth_key, 
                            :secret => Secrets.linkedin_oauth_secret } if Secrets.linkedin_oauth_key

credentials[:fireeagle] = { :key => Secrets.fireeagle_oauth_key,
                            :secret => Secrets.fireeagle_oauth_secret } if Secrets.fireeagle_oauth_key

credentials[:friendfeed] = { :key => Secrets.friendfeed_oauth_key,
                             :secret => Secrets.friendfeed_oauth_secret } if Secrets.friendfeed_oauth_key
                             
OAUTH_CREDENTIALS = credentials unless defined? OAUTH_CREDENTIALS
load 'oauth/models/consumers/service_loader.rb'