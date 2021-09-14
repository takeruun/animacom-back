json.follows do
  json.partial! 'v1/users/follows/followers', followers: @followers, user: @user
  json.partial! 'v1/users/follows/followings', followings: @followings, user: @user
end