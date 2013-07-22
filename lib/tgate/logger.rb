require 'pp'
module Tgate
  class Logger
    def initialize(response = {})
      puts "------------------------ Credit Response ----------------------------"
      puts response.result_message
      puts "Approved:   #{response.approved}"
      puts "Error Code: #{response.error}" if response.error
      puts "_____________________________________________________________________"
    end
  end
end
