json.comments @comments do |comment|
  json.id comment.id
  json.user_id comment.user_id
  json.post_id comment.post_id
  json.body comment.body
  json.created_at comment.created_at
end