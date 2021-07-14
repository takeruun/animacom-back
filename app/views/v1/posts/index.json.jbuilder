json.posts @posts do |post|
  json.id post.id
  json.user_id post.user.id
  json.title post.title
  json.sub_title post.sub_title
  json.body post.body
  json.category_id post.category.id

  json.images post.images do |image|
    json.id image.id
    json.image_path image.image.url
  end
end