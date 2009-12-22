require 'oauth/controllers/consumer_controller'
class OauthConsumersController < ApplicationController
  include Oauth::Controllers::ConsumerController
  
  layout :choose_layout
  
  def index
  end
  
  protected
  
    # Change this to decide where you want to redirect user to after callback is finished.
    # params[:id] holds the service name so you could use this to redirect to various parts
    # of your application depending on what service you're connecting to.
    def go_back
      debugger
      redirect_to root_url
    end
  
    def choose_layout
      'popup'
    end
  
end
