Ransack.configure do |c|
  # Change default search parameter key name.
  # Default key name is :q
  c.search_key = :search

  # Change whitespace stripping behavior.
  # Default is true
  c.strip_whitespace = true

  c.add_predicate 'array_contains',
    arel_predicate: 'contains',
    formatter: proc { |v| "{#{v}}" },
    validator: proc { |v| v.present? },
    type: :array

  c.custom_arrows = {
    up_arrow: '<i class="bi bi-sort-up"></i>',
    down_arrow: '<i class="bi bi-sort-down"></i>',
    default: '<i class="bi bi-filter"></i>'
  }
end