A gem for processing credit cards with Tgate's API.

## Setup

Add it to your Gemfile then run `bundle` to install it.

```ruby
gem "tgate"
```


## Usage
###Create Virtual Merchant Objects
```ruby
    #Create CreditCard via manual entry
    cc = Tgate::CreditCard.from_manual(
      name_on_card: <name_on_card>,
      number: <card_number>,
      expiration: <card_exp>,
      security_code: <cvv2>)

    # OR
    # via MSR
    cc = Tgate::CreditCard.from_swipe(<swipe_data>)

    amount = Tgate::Amount.new(
      total: <total amount to charge>,
      tax: <amount of tax included in the total, optional>)

    creds = Tgate::Credentials.new(
      account_id: <vm_account_id>,
      user_id: <vm_user_id>,
      pin: <vm_user_pass>,
      demo: <boolean, optional>,
      referer: <uri of the http referer, optional>)
```

###Charge, Refund, or Void
```ruby
    #Charge
    response = Tgate.charge(cc, amount, creds)

    #Refund
    response = Tgate.refund(cc, amount, creds)

    #Void
    response = Tgate.void(transaction_id, creds)
```

The response returned is a Tgate::Response object.

If the transaction was sucessful and the card was approved, the response will have the following attrs:

    * result_type: "approval"
    * result_message: ssl_result_message
    * result: ssl_result
    * approval_code: ssl_approval_code
    * blurred_card_number: ssl_card_number
    * exp_date: ssl_exp_date
    * cvv2_response: ssl_cvv2_response
    * transaction_id: ssl_txn_id
    * transaction_time: ssl_txn_tim
    * approved: true


Otherwise there was some problem with the transaction, so the response will have these attrs:

    * result_type: "error"
    * error: errorCode
    * result_message: errorMessage
    * approved: false


For more information on the Virtual Merchant API, view their docs at
https://www.myvirtualmerchant.com/Tgate/supportlandingvisitor.do
