json.followings @followings do |following|
  json.partial! 'v1/users/index', user: following
end