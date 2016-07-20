class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def deny_anonymous_user
    redirect_to "/signup" unless current_user
  end

  def deny_signned_in_user
    redirect_to root_path if current_user
  end

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
