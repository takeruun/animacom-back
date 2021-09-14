json.following_count followings.count
json.followings followings do |following|
  json.partial! 'v1/users/index', user: following, current_user: user
end