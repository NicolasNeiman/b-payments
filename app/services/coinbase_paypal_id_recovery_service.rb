class CoinbasePaypalIdRecoveryService < ApplicationService
  def initialize(user)
    @user = user
  end

  def call
    @user.coinbase_paypal_account_id = get_paypal_id(@user)
    @user.save
  end

  private

  def get_paypal_id(user)
    url = "https://api.coinbase.com/v2/payment-methods"
    headers = {
      "Content-Type"  => "application/json",
      "Authorization" => "Bearer #{user.coinbase_token}"
    }
    payment_methods = HTTParty.get(url, :headers => headers)["data"]
    paypal_accounts = payment_methods.select { |payment_method| payment_method["type"] == "paypal_account"}
    paypal_account = paypal_accounts.first
    return paypal_account["id"]
  end
end