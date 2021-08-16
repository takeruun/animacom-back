json.followers @followers do |follower|
  json.partial! 'v1/users/index', user: follower
end