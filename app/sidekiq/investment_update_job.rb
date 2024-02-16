class InvestmentUpdateJob
  include Sidekiq::Job

  def perform(investment_id)
    investment = Investment.find_by(id: investment_id)
    return if investment.blank?
    return unless investment.deal.live? 
    return unless investment.committed_amount?
    return unless investment.completed!

    InvestmentsMailer::completed(investment, investment.deal).deliver_now
  end
end
