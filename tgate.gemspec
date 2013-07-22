Gem::Specification.new do |s|
  s.name        = 'tgate'
  s.version     = '0.0.1'
  s.date        = '2013-07-18'
  s.summary     = "T-Gate API"
  s.description = "Makes it easy to charge credit cards with the T-Gate API."
  s.authors     = ["Lee Quarella"]
  s.email       = 'lee@lucidfrog.com'
  s.files       = ["lib/tgate.rb",
                   "lib/tgate/amount.rb",
                   "lib/tgate/communication.rb",
                   "lib/tgate/credentials.rb",
                   "lib/tgate/credit_card.rb",
                   "lib/tgate/logger.rb",
                   "lib/tgate/response.rb",
                   "lib/tgate/xml_generator.rb",
                   "lib/tgate/gateway.rb"]
  s.homepage    = 'https://github.com/leequarella/tgate-ruby'
end
