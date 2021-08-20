json.user do
  json.partial! 'v1/users/index', user: @user, current_user: @current_user
end