class Gateway
  attr_reader :creds

  def initialize(creds)
    @creds = creds
  end

  def sale(card, amount)
    params = generate_params(card, amount, "Sale")
    process(params, amount)
  end

  def return(card, amount)
    params = generate_params(card, amount, "Return")
    process(params, amount)
  end

  def void(transaction_id)
    params = generate_params("Void")
    process(params)
  end

  def process(params, amount=0)
    communication = Tgate::Communication.new(
      {params: params, url: url})
    tgate_response = communication.send
    response = Tgate::Response.new(tgate_response)
    Tgate::Logger.new(response)
    response
  end

  private
  def generate_params(card, amount, transaction_type)
    Tgate::PostParams.new({
      card: card,
      amount: amount,
      creds: creds,
      transaction_type: transaction_type}).params
  end
  def url
    case creds.type
    when 'test'
      "https://gatewaystage.itstgate.com/SmartPayments/transact.asmx/ProcessCreditCard"
    else
      "https://gateway.itstgate.com/SmartPayments/transact.asmx/ProcessCreditCard"
    end
  end
end
