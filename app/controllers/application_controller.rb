class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  include SessionsHelper

  private
    # 确保用户已登录
    def logged_in_user
      unless logged_in?
        store_location

        error_massage = "Please log in."
        flash[:danger] = error_massage

        if request.format == :html
          redirect_to login_url
        else
          render json: {error: true, description: error_massage}
        end
      end
    end

end
