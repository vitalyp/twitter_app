class SessionsController < ApplicationController
  http_basic_authenticate_with name: "band", password: "lab", only: :sandbox


  def new
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def sandbox
    flash[:success] = `Вы вошли под случайным пользователем!`
    session[:user_id] = User.pluck(:id).sample
    redirect_to root_url
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
  
  private
  def user_params
    params.require(:user).permit(:provider, :uid, :name, :oauth_token, :oauth_expires_at) 
  end

  def auth
    request.env['omniauth.auth']
  end
  
end
