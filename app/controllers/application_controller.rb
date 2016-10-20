class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  # ログインした時の遷移先
  def after_sign_in_path_for(resource)
    resume_url
  end
  
  # ログアウトした時の遷移先
  def after_sign_out_path_for(resource)
    new_user_session_url
  end
  
  # CanCanでアクセス権エラーが発生した場合
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end
  
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) << :name
      devise_parameter_sanitizer.for(:account_update) << :email
      devise_parameter_sanitizer.for(:account_update) << :image
    end
end
