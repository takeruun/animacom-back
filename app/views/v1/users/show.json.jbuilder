json.user do
  json.partial! 'v1/users/index', user: @user
end