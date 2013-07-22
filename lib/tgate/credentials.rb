module Tgate
  class Credentials
    attr_accessor :UserName, :Password, :type
    def initialize(info)
      @UserName = info[:UserName].to_s
      @Password = info[:Password].to_s
      @type = info[:type].to_s
    end
  end
end
