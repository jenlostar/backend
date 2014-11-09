json.(user, :id, :first_name, :last_name, :email, :gender, :phone_number)
json.access_token generate_access_token(user).token
json.ratings user.ratings
