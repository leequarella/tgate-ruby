require 'pp'
require "rexml/document"

module Tgate
  class Response
    attr_accessor :result_message, :result, :blurred_card_number, :exp_date,
      :approval_code, :cvv2_response, :transaction_id, :transaction_time, :error,
      :approved

    alias_method :approved?, :approved

    def initialize(xml_string)
      if xml_string == false
        error_response
      else
        decode_xml(xml_string)
      end
    end


    private
    def decode_xml(xml_string)
      doc = REXML::Document.new(xml_string)
      puts doc
      REXML::XPath.each(doc, "Response") do |xml|
        if declined?(xml)
          decline_response(xml)
        else
          approval(xml)
        end
      end
    end

    def declined?(xml)
      if xml.elements["RespMSG"].text == "Approved"
        false
      else
        true
      end
    end

    def error_response
      @result_message = "Failed to connect to T-Gate."
      @approved = false
      @error = -1
    end

    def decline_response(xml)
      @result_message = xml.elements["RespMSG"].text
      @approved = false
      @error = xml.elements["Result"].text
    end

    def approval(xml)
      @approved = true
      @result_message = xml.elements["RespMSG"].text
      #@result = xml.elements["ssl_result"].text
      #@blurred_card_number = xml.elements["ssl_card_number"].text
      #@exp_date = xml.elements["ssl_exp_date"].text
      #@approval_code = xml.elements["ssl_approval_code"].text
      #@cvv2_response = xml.elements["ssl_cvv2_response"].text
      #@transaction_id = xml.elements["ssl_txn_id"].text
      #@transaction_time = xml.elements["ssl_txn_time"].text
    end
  end
end
