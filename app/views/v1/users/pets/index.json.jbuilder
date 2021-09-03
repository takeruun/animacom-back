json.pets @pets do |pet|
  json.partial! 'v1/users/pets/index', pet: pet
end