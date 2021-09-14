json.user do
  json.partial! 'v1/users/index', user: @user, current_user: @current_user
  json.pet_count @user.pets.count
end