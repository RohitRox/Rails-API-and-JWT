class Api::ProfilesController < Api::BaseController
  skip_before_filter :authenticate_user_from_token!, only: [:show]
  before_filter :set_user

  def show
  end

  def update
    return render_unauthorized unless allowed_to_edit_profile?
    @profile = @user.profile || @user.build_profile
    @profile.update_attributes(profile_params)
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :gender, :location, :avatar_url, :bio)
    end

    def allowed_to_edit_profile?
      @user == @current_user
    end
end
