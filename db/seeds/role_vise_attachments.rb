['Individual Investor', 'Investment Firm', 'Syndicate', 'Realtor', 'Startup'].each do |title|
  role = Role.new(title: title)
  p role.save ? "Added Role: #{title}" : role.errors.full_messages.to_sentence
end

Role.all.each do |role|
  [
    { name: 'Proof of identity', label: 'Upload a photo of your passport.' },
    { name: 'Identity verification', label: 'Upload your selfie with passport copy.' },
    { name: 'Proof of residence', label: 'Upload your property document copy.' }
  ].each do |attachment, index|
    attachment_config = role.role_vise_attachments.new(
      name: attachment[:name],
      label: attachment[:label],
      index: index
    )
    p attachment_config.save ? "Successfuly added attachment configuration" :
                                attachment_config.errors.full_messages.to_sentence
  end
end
