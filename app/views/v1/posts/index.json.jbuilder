json.posts @posts.each do |post|
  json.id post.id
  json.user_id post.user.id
  json.title post.title
  json.sub_title post.sub_title
  json.body post.body
  json.category_id post.category.id
end