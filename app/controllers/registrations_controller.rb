class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(sign_up_params)
    if @user.save
      sign_in(:user, @user)
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong, check the form!"
      redirect_to new_user_registration_path
    end
  end

private

  def sign_up_params
    params.require(:user).permit(:email, :user_name, :password,
    :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :user_name, :password,
    :password_confirmation, :current_password)
  end
end
