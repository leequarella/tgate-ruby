module Tgate
  class Communication
    require 'net/http'

    attr_accessor :params, :http_referer, :uri

    def initialize(data)
      @params = data[:params]
      @uri = URI.parse(data[:url])
    end

    def send
      http = Net::HTTP.new(@uri.host, @uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      begin
        http.post(uri.request_uri, params, header).body
      rescue Exception => e
        false
      end
    end

    private
    def header
      header = {}
    end
  end
end
