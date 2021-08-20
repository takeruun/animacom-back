json.follower_count followers.count
json.followers followers do |follower|
  json.partial! 'v1/users/index', user: follower, current_user: user
end