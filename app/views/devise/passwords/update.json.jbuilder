if @user.errors.any?
  json.partial! 'layouts/errors', errors: @user.errors
  json.status false
else
	json.partial! 'users/user', user: @user
  json.message t('users.password.success_updated')
	json.status true
end