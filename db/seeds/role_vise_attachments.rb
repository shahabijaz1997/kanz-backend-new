['Individual Investor', 'Investment Firm', 'Syndicate', 'Realtor', 'Startup'].each do |title|
  role = Role.new(title: title)
  p role.save ? "Added Role: #{title}" : role.errors.full_messages.to_sentence
end

Role.all.each do |role|
  [
    { 
      name: 'Proof of identity',
      label: 'Upload a photo of your passport.',
      name_ar: 'إثبات الهوية',
      label_ar: 'قم بتحميل صورة من جواز سفرك'
    },
    { 
      name: 'Identity verification',
      label: 'Upload your selfie with passport copy.',
      name_ar: 'التحقق من الهوية',
      label_ar: 'قم بتحميل صورتك الشخصية مع نسخة من جواز السفر'
    },
    { 
      name: 'Proof of residence',
      label: 'Upload your property document copy.',
      name_ar: 'دليل الإقامة',
      label_ar: 'تحميل نسخة وثيقة الملكية الخاصة بك'
    }
  ].each do |attachment, index|
    record = role.role_vise_attachments.find_or_initialize_by(name: attachment[:name])
    record.update(attachment)

    p record.save ? "Successfuly added attachment configuration" :
                    record.errors.full_messages.to_sentence
  end
end
