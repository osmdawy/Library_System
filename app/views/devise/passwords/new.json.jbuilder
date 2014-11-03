if @user.nil?
  json.message t('users.email.invalid')
  json.status false
else
  json.message t('users.password.success_sent')
	json.status true
end