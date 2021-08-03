json.root_categories @categories do |category|
  json.id category.id.to_s
  json.name category.name
end