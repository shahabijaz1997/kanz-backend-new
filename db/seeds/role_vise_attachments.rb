# frozen_string_literal: true

[
  { title: 'Individual Investor', title_ar: 'فرد' },
  { title: 'Investment Firm', title_ar: 'شركة' },
  { title: 'Syndicate', title_ar: 'نقابة' },
  { title: 'Realtor', title_ar: 'سمسار عقارات' },
  { title: 'Startup', title_ar: 'بدء' }
].each do |role|
  record = Role.find_or_initialize_by(title: role[:title])

  if record.update(role)
    Rails.logger.debug { "Added Role: #{role[:title]}" }
  else
    Rails.logger.debug { record.errors.full_messages.to_sentence }
  end
end

attachment_config = {
  investor: [
    {
      index: 0,
      name: 'Proof of identity',
      label: 'Upload a photo of your passport.',
      name_ar: 'إثبات الهوية',
      label_ar: 'قم بتحميل صورة من جواز سفرك'
    },
    {
      index: 1,
      name: 'Identity verification',
      label: 'Upload your selfie with passport copy.',
      name_ar: 'التحقق من الهوية',
      label_ar: 'قم بتحميل صورتك الشخصية مع نسخة من جواز السفر'
    },
    {
      index: 2,
      name: 'Proof of residence',
      label: 'Upload your property document copy.',
      name_ar: 'دليل الإقامة',
      label_ar: 'تحميل نسخة وثيقة الملكية الخاصة بك'
    }
  ],
  realtor: [
    {
      index: 0,
      name: 'Proof of Identity',
      label: 'Upload a scanned copy of your passport',
      name_ar: 'إثبات الهوية',
      label_ar: 'قم بتحميل صورة من جواز سفرك'
    },
    {
      index: 1,
      name: 'Identity Verification',
      label: 'Take a selfie with your passport',
      name_ar: 'التحقق من الهوية',
      label_ar: 'قم بتحميل صورتك الشخصية مع نسخة من جواز السفر'
    },
    {
      index: 2,
      name: 'Proof of Residence',
      label: 'Upload your tenancy contract',
      name_ar: 'دليل الإقامة',
      label_ar: 'تحميل نسخة وثيقة الملكية الخاصة بك'
    }
  ],
  syndicate: [
    {
      index: 0,
      name: 'Proof of identity',
      label: 'Upload a photo of your passport.',
      name_ar: 'إثبات الهوية',
      label_ar: 'قم بتحميل صورة من جواز سفرك'
    },
    {
      index: 1,
      name: 'Identity verification',
      label: 'Upload your selfie with passport copy.',
      name_ar: 'التحقق من الهوية',
      label_ar: 'قم بتحميل صورتك الشخصية مع نسخة من جواز السفر'
    },
    {
      index: 2,
      name: 'Proof of residence',
      label: 'Upload your property document copy.',
      name_ar: 'دليل الإقامة',
      label_ar: 'تحميل نسخة وثيقة الملكية الخاصة بك'
    }
  ],
  startup: [
    {
      index: 0,
      name: 'Proof of Identity',
      label: 'Upload a scanned copy of your passport',
      name_ar: 'إثبات الهوية',
      label_ar: 'قم بتحميل صورة من جواز سفرك'
    },
    {
      index: 1,
      name: 'Identity Verification',
      label: 'Take a selfie with your passport',
      name_ar: 'التحقق من الهوية',
      label_ar: 'قم بتحميل صورتك الشخصية مع نسخة من جواز السفر'
    },
    {
      index: 2,
      name: 'Proof of Residence',
      label: 'Upload your tenancy contract',
      name_ar: 'دليل الإقامة',
      label_ar: 'تحميل نسخة وثيقة الملكية الخاصة بك'
    }
  ]
}
Role.all.each do |role|
  role.attachment_configs&.destroy_all
  attachments = attachment_config[role.title.downcase.to_sym] || attachment_config[:investor]
  attachments.each do |attachment, _index|
    record = role.attachment_configs.find_or_initialize_by(name: attachment[:name])

    if record.update(attachment)
      Rails.logger.debug { 'Successfuly added attachment configuration' }
    else
      Rails.logger.debug { record.errors.full_messages.to_sentence }
    end
  end
end
