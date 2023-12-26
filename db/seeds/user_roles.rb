[
  { title: 'Individual Investor', title_ar: 'فرد' },
  { title: 'Investment Firm', title_ar: 'شركة' },
  { title: 'Syndicate', title_ar: 'نقابة' },
  { title: 'Fund Raiser', title_ar: 'جامع الأموال' },
].each do |role|
  record = Role.find_or_initialize_by(title: role[:title])

  if record.update(role)
    Rails.logger.debug { "Added Role: #{role[:title]}" }
  else
    Rails.logger.debug { record.errors.full_messages.to_sentence }
  end
end
