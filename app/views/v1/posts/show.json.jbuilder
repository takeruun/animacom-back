json.post do
  json.partial! 'v1/posts/post', post: @post, user: current_v1_users_user
end