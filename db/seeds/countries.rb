countries = [
  { name: 'Bahrain',
    states: ['Manama', 'Riffa', 'Muharraq', 'Hamad Town', "A'ali", 'Isa Town', 'Sitra', 'Budaiya', 'Jidhafs',
             'Al-Malikiyah'] },
  { name: 'Kuwait', states: ['Capital', 'Hawalli', 'Mubarak Al-Kabeer', 'Ahmadi', 'Farwaniya', 'Jahra'] },
  { name: 'Qatar',
    states: ['Al Shamal', 'Al Khor', 'Al-Shahaniya', 'Umm Salal', 'Al Daayen', 'Doha (Ad Dawhah)', 'Al Rayyan',
             'Al Wakra'] },
  { name: 'Oman',
    states: ['Musandam', 'Al Buraimi', 'Al Batinah North', 'Al Batinah South', 'Muscat', "A'Dhahirah", "A'Dakhiliya",
             "A'Sharqiyah North", "A'Sharqiyah South", 'Al Wusta', 'Dhofar'] },
  { name: 'Saudi Arabia',
    states: ['Mecca', 'Riyadh', 'Eastern Region', "'Asir", 'Jazan', 'Medina', 'Al-Qassim', 'Tabuk', 'Najd', "Ha'il",
             'Najran', 'Al-Jawf', 'Al-Bahah', 'Northern Borders'] },
  { name: 'United Arab Emirates',
    states: ['Abu Dhabi', 'Dubai', 'Sharjah', 'Umm Al Qaiwain', 'Fujairah', 'Ajman', 'Ras Al Khaimah'] }
]


countries.each do |country|
  next if Country.exists?(name: country[:name])

  record = Country.new(country)
  if record.save
    p "Added country: #{country[:name]}"
  else
    p "Failed to save country with errors: #{record.errors.full_messages.to_sentence}"
  end
end
