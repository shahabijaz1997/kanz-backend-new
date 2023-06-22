[
  {title: 'Individual Investor', title_ar: 'فرد' },
  {title: 'Investment Firm', title_ar: 'شركة' },
  {title: 'Syndicate', title_ar: 'نقابة' },
  {title: 'Realtor', title_ar: 'سمسار عقارات'},
  {title: 'Startup', title_ar: 'بدء'}
].each do |role|
  record = Role.find_or_initialize_by(title: role[:title])

  p record.update(role) ? "Added Role: #{role[:title]}" : record.errors.full_messages.to_sentence
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

    p record.update(attachment) ? "Successfuly added attachment configuration" :
                    record.errors.full_messages.to_sentence
  end
end
