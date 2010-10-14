module MuckOauth
  
  def self.configuration
    # In case the user doesn't setup a configure block we can always return default settings:
    @configuration ||= Configuration.new
  end
  
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    
    attr_accessor :enable_solr
    
    def initialize
      self.enable_solr = true
    end
    
  end
end