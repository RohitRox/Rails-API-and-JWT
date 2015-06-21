if @user.errors.present?
  json.errors @user.errors.messages
  json.response do
    json.code 422
  end
else
  json.data do
    json.email @user.email
  end
  json.response do
    json.code 201
  end
end
