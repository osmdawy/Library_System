if @user.errors.any?
  json.partial! 'layouts/errors', errors: @user.errors
  json.status false
else
	json.partial! 'users/user', user: @user
	json.status true
end