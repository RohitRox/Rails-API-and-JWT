#spec/helpers/controller_spec_helpers.rb
module ControllerSpecHelpers
  def authenticate(user=nil)
    user = user || create(:user)
    token = JsonWebToken.encode('user' => user.email)
    request.headers['Authorization'] = "AUTH-BASIC #{token}"
  end
end
