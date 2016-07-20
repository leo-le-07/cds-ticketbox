class SessionsController < ApplicationController
  def new
  end

  def create
    user = UserLogin.new.login(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = "Chào mừng bạn đã trở lại"
      redirect_to root_path
    else
      flash[:notice] = "Email hoặc mật khẩu không chính xác"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    render 'new'
  end
end
