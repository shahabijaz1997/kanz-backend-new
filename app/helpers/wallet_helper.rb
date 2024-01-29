# frozen_string_literal: true

module WalletHelper
  def balance_available?(amount, converted: false)
    current_user.wallet.balance >= (converted ? usd_to_aed(amount) : BigDecimal(amount))
  end

  def usd_to_aed(amount)
    BigDecimal(amount) * (ExchangeRate.current.rate || DEFAULT_EXCHANGE_RATE)
  end
end
