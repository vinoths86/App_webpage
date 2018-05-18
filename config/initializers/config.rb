class Webapp

  class Configuration
    def initialize
      @api_url = ENV.fetch('API_URL')
    end

    attr_reader :api_url
  end

  def self.config
    @config ||= Configuration.new
  end

end