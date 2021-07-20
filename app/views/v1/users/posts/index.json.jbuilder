json.posts @posts do |post|
  json.partial! 'v1/users/posts/post', post: post, user: current_v1_users_user
end