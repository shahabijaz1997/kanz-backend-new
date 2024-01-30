# frozen_string_literal: true
module V1
  class WalletsController < ApiController
    before_action :set_wallet

    def show
      render json: {
        wallet: WalletSerializer.new(@wallet).serializable_hash[:data][:attributes]
      }
    end

    private

    def set_wallet
      @wallet = current_user.wallet
    end
  end
end