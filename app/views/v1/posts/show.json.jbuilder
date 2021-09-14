json.post do
  json.partial! 'v1/posts/post', post: @post
end