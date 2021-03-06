class CoinbaseEurBalanceRecoveryService < ApplicationService
  def initialize(user)
    @user = user
    CoinbaseRefreshTokenRecoveryService.call(@user)
    @balance = nil
  end

  def call
    url = "https://api.coinbase.com/v2/accounts/#{@user.coinbase_eur_account_id}"
    headers = {
      "Content-Type"  => "application/json",
      "Authorization" => "Bearer #{@user.coinbase_token}"
    }

    begin
      coinbase_api_answer = HTTParty.get(url, headers: headers)
    rescue
      coinbase_api_answer = {}
    end

    original_balance = coinbase_api_answer.dig("data", "balance")

    unless original_balance.nil?
      @balance = {
        "EUR" => original_balance["amount"]
      }
    end

    return @balance
  end

  def success?
    !@balance.nil?
  end
end
