Ransack.configure do |c|
  # Change default search parameter key name.
  # Default key name is :q
  c.search_key = :search

  # Change whitespace stripping behavior.
  # Default is true
  c.strip_whitespace = true
end