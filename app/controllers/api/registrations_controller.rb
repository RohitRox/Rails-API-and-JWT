class Api::RegistrationsController < Api::BaseController

  def create
    @user = User.new(user_params)
    @user.save
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
