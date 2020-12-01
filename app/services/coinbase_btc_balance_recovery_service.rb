class CoinbaseBtcBalanceRecoveryService < ApplicationService
  def initialize(user)
    @user = user
    CoinbaseRefreshTokenRecoveryService.call(@user)
  end

  def call
    return { "error" => "We don't have an eur account" } unless @user.coinbase_btc_account_id

    url = "https://api.coinbase.com/v2/accounts/#{@user.coinbase_btc_account_id}"
    headers = {
      "Content-Type"  => "application/json",
      "Authorization" => "Bearer #{@user.coinbase_token}"
    }

    coinbase_api_answer = HTTParty.get(url, headers: headers)
    begin
      balance = HTTParty.get(url, headers: headers)["data"]["balance"]
    rescue
      balance = { "error" => "We were not able to retrieve the balance" }
    end

    return balance
  end
end