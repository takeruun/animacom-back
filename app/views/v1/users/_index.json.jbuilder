json.id user.id
json.name user.name
json.nickname user.nickname
json.image do
  json.image_path user.image.url
end
json.introduction user.introduction
json.follower_count user.followers.count
json.following_count user.followings.count
json.follow current_user&.follow?(user)