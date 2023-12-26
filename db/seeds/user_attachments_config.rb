# frozen_string_literal: true

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
  fund_raiser: [
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
