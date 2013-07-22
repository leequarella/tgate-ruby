require "rexml/document"
require 'tgate/amount'
require 'tgate/communication'
require 'tgate/credentials'
require 'tgate/credit_card'
require 'tgate/response'
require 'tgate/logger'
require 'tgate/post_params'
require 'tgate/gateway'
module Tgate
  def self.charge(card, amount, creds, gateway=Gateway.new(creds))
    gateway.sale(card, amount)
  end

  def self.refund(card, amount, creds, gateway=Gateway.new(creds))
    gateway.return(card, amount)
  end

  def self.void(transaction_id, creds, gateway=Gateway.new(creds))
    gateway.void(transaction_id)
  end
end
