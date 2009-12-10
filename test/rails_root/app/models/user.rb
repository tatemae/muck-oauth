class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end
  acts_as_muck_user
  has_activities
  has_many :uploads, :as => :uploadable, :order => 'created_at desc', :dependent => :destroy 
  
  has_many :client_applications
  has_many :tokens, :class_name => "OauthToken", :order => "authorized_at desc", :include => [:client_application]
  
  def can_add_root_content?
    admin?
  end
  
  def can_upload?(check_user)
    true
  end
  
end