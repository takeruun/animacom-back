json.users @users do |user|
  json.partial! 'v1/users/index', user: user, current_user: @user
end