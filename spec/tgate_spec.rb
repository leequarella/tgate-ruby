require 'spec_helper'
require 'tgate'

describe Tgate, vcr: true do
  let :valid_creds do
    Tgate::Credentials.new(
      UserName: "BCPr2626",
      Password: "E4727lv1",
      type: 'test')
  end

  let :invalid_creds do
    Tgate::Credentials.new(
      UserName: "BADUNAME",
      Password: "BADPASS",
      type: 'test')
  end

  let :valid_cc do
    Tgate::CreditCard.new(
      name_on_card: "Lee M Cardholder",
      number: "4012000033330026",
      expiration: "1016",
      security_code: "1234")
  end

  let :invalid_cc do
    Tgate::CreditCard.new(
      name_on_card: "Lee M Cardholder",
      number: "1234567890123456",
      expiration: "0513",
      security_code: "1234")
  end

  let(:amount) { rand * 10 }

  let(:gateway_url) { "gatewaystage.itstgate.com" }

  describe "failed to connect" do
    context "no response", vcr: false do
      it "gives the proper result message" do
        stub_request(:any, gateway_url).to_raise(StandardError)
        response = Tgate.charge(valid_cc, amount, valid_creds)
        response.should_not be_approved
        response.result_message.should eq "Failed to connect to T-Gate."
      end
    end
    context "invalid credentials" do
      it "gives the proper result message" do
        response = Tgate.charge(valid_cc, amount, invalid_creds)
        response.should_not be_approved
        response.result_message.should eq "Invalid Login Information 2"
      end
    end
  end

  describe "Charging a card" do
    context "Happy Approval" do
      it "generates an approval response" do
        response = Tgate.charge(valid_cc, amount, valid_creds)
        response.should be_approved
      end
    end
    context "Un-Happy Approval", vcr: false do
      xit "generates an error response" do
        #stub_request(:any, gateway_url)
        #  .with(body: bad_approval_xml)
        response = Tgate.charge(valid_cc, amount, valid_creds)
        response.should_not be_approved
      end
    end
    context "Straight error response" do
      xit "generates an error response" do
        response = Tgate.charge(invalid_cc, amount, valid_creds)
        response.should be_an_instance_of Tgate::Response
        response.should_not be_approved
      end
    end
  end

  describe "Refunding a card" do
    context "Happy Approval" do
      xit "generates an approval response" do
        response = Tgate.refund(valid_cc, amount, valid_creds)
        response.should be_approved
      end
    end
    context "Un-Happy Approval", vcr: false do
      xit "generates an error response" do
        #stub_request(:any, gateway_url)
        #  .with(body: bad_approval_xml)
        response = Tgate.refund(valid_cc, amount, valid_creds)
        response.should_not be_approved
      end
    end
    context "Straight error response" do
      xit "generates an error response" do
        response = Tgate.refund(invalid_cc, amount, valid_creds)
        response.should_not be_approved
      end
    end
  end

  describe "Voiding a card" do
    context "successful void" do
      xit "generates an approval response" do
        response = Tgate.charge(valid_cc, amount, valid_creds)
        response = Tgate.void(response.transaction_id, valid_creds)
        response.should be_approved
      end
    end
    context "failed void" do
      xit "generates an error response" do
        response = Tgate.void(123, valid_creds)
        response.should_not be_approved
      end
    end
  end
end
