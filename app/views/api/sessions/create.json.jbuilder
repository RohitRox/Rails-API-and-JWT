json.data do
  json.email @user.email
  json.auth_token @auth_token
  json.profile @user.profile
end
json.response do
  json.code 200
end
