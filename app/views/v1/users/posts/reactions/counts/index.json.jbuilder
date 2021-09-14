json.reactions do
  json.counts @counts do |count|
    json.kind count.kind
    json.count count.count
  end
end
