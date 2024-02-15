# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show update]
  before_action :authorize_role!

  def index
    @filtered_transactions = Transaction.ransack(params[:search])
    @filtered_transactions.status_eq = Transaction.statuses[:pending] if params[:search].blank? && Transaction.pending.present?
    @pagy, @transactions = pagy(policy_scope(@filtered_transactions.result.includes(wallet: :user).order(created_at: :desc)))
  end

  def show
    @user = @transaction.wallet.user 
  end

  def update
    respond_to do |format|
      if @transaction.update(permitted_params)
        format.html { redirect_to @transaction, notice: 'Successfully updated.' }
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_transaction
    @transaction = policy_scope(Transaction).find(params[:id])
  end

  def permitted_params
    params.require(:transaction).permit(:audit_comment, :status)
  end
end
