json.follows do
  json.followers @followers do |follower|
    json.partial! 'v1/users/index', user: follower
  end
  json.followings @followings do |following|
    json.partial! 'v1/users/index', user: following
  end
end