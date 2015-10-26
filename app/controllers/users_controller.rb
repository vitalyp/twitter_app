class UsersController < ApplicationController
  before_action :require_login
  before_filter :set_user, only: [:show, :edit, :update]

  def show
    current_user.build_profile if current_user.profile.nil?
  end

  def edit
    current_user.build_profile if current_user.profile.nil?
  end

  def update
    if current_user.update(user_params)
      redirect_to user_profile_path(current_user)
    else
      render 'edit'
    end
  end

  private

  def set_user
    @user = current_user
  end


  def user_params
    params.require(:user).permit(profile_attributes: [:id, :name, :first_name, :last_name, :email, :picture_url, :avatar])
  end

  def authenticate_owner!
    redirect_to root_path unless current_user && current_user.to_param == params[:id]
  end
end