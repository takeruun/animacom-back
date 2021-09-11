json.pet do
  json.partial! 'v1/users/pets/index', pet: @pet
end