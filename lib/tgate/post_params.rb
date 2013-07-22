module Tgate
  class PostParams
    attr_reader :transaction_id, :creds, :transaction_type, :card,
      :amount, :params
    def initialize(info)
      @transaction_type = info[:transaction_type]
      @transaction_id   = info[:transaction_id]
      @creds            = info[:creds]
      @card             = info[:card]
      @amount           = info[:amount]
      @params           = generate
    end

    private
    def generate
      "UserName=   #{creds.UserName}
       &Password=  #{creds.Password}
       &TransType= #{transaction_type}
       &CardNum=   #{card.number}
       &ExpDate=   #{card.expiration}
       &MagData=   #{}
       &NameOnCard=#{card.name_on_card}
       &Amount=    #{amount}
       &INVnum=
       &Zip=
       &Street=
       &PNRef=
       &CVNum=
       &ExtData="
       .gsub(/\s+/, "")
    end
  end
end
