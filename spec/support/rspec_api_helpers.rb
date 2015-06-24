module RspecApiHelpers
  def set_auth_headers(user=nil)
    user = user || User.create!(email: "test+user@example.com", password: "password")
    token = JsonWebToken.encode('user' => user.email)
    header "Authorization", "AUTH-BASIC #{token}"
  end
end
