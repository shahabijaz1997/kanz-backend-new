['Individual Investor', 'Investment Firm', 'Syndicate', 'Realtor', 'Startup'].each do |title|
  role = Role.new(title: title)
  p role.save ? "Added Role: #{title}" : role.errors.full_messages.to_sentence
end
