regions = [{
  name: 'Asia',
  name_ar: 'آسيا'
},{
  name: 'Europe',
  name_ar: 'أوروبا'
},{
  name: 'North america',
  name_ar: 'أمريكا الشمالية'
},{
  name: 'South America',
  name_ar: 'أمريكا الجنوبية'
},{
  name: 'Africa',
  name_ar: 'أفريقيا'
},{
  name: 'Oceania',
  name_ar: 'أوقيانوسيا'
},{
  name: 'Antarctica',
  name_ar: 'أنتاركتيكا'
}]
regions.each do |region|
  record = Region.find_or_initialize_by(name: region[:name])

  if record.update(region)
    Rails.logger.debug { "Added region: #{region[:name]}" }
  else
    Rails.logger.debug { "Failed to save region: #{record.errors.full_messages.to_sentence}" }
  end
end