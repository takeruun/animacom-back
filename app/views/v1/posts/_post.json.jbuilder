json.id post.id
json.title post.title
json.sub_title post.sub_title
json.body post.body
json.category_id post.category_id

json.images post.images do |image|
  json.id image.id
  json.image_path image.image.url
end

json.cute_count post.cute_count
json.fav_count post.fav_count
json.good_count post.good_count
json.cool_count post.cool_count

json.already_cuted user&.already_cuted?(post.id)
json.already_faved user&.already_faved?(post.id)
json.already_gooded user&.already_gooded?(post.id)
json.already_cooled user&.already_cooled?(post.id)