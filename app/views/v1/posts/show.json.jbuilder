json.post do
  json.id @post.id
  json.title @post.title
  json.sub_title @post.sub_title
  json.body @post.body
  json.category_id @post.category_id
end