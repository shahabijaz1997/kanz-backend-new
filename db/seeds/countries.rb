countries = [
  {
    name: 'Bahrain',
    name_ar: 'البحرين',
    states: ['Manama', 'Riffa', 'Muharraq', 'Hamad Town', "A'ali", 'Isa Town', 'Sitra', 'Budaiya', 'Jidhafs',
             'Al-Malikiyah']
  },
  {
    name: 'Kuwait',
    name_ar: 'الكويت',
    states: ['Capital', 'Hawalli', 'Mubarak Al-Kabeer', 'Ahmadi', 'Farwaniya', 'Jahra']
  },
  {
    name: 'Qatar',
    name_ar: 'دولة قطر',
    states: ['Al Shamal', 'Al Khor', 'Al-Shahaniya', 'Umm Salal', 'Al Daayen', 'Doha (Ad Dawhah)', 'Al Rayyan',
             'Al Wakra']
  },
  {
    name: 'Oman',
    name_ar: 'سلطنة عمان',
    states: ['Musandam', 'Al Buraimi', 'Al Batinah North', 'Al Batinah South', 'Muscat', "A'Dhahirah", "A'Dakhiliya",
             "A'Sharqiyah North", "A'Sharqiyah South", 'Al Wusta', 'Dhofar']
  },
  {
    name: 'Saudi Arabia',
    name_ar: 'المملكة العربية السعودية',
    states: ['Mecca', 'Riyadh', 'Eastern Region', "'Asir", 'Jazan', 'Medina', 'Al-Qassim', 'Tabuk', 'Najd', "Ha'il",
             'Najran', 'Al-Jawf', 'Al-Bahah', 'Northern Borders']
  },
  {
    name: 'United Arab Emirates',
    name_ar: 'الإمارات العربية المتحدة',
    states: ['Abu Dhabi', 'Dubai', 'Sharjah', 'Umm Al Qaiwain', 'Fujairah', 'Ajman', 'Ras Al Khaimah']
  }
]

countries.each do |country|
  record = Country.find_or_initialize_by(name: country[:name])
  
  if record.update(country)
    p "Added country: #{country[:name]}"
  else
    p "Failed to save country with errors: #{record.errors.full_messages.to_sentence}"
  end
end
