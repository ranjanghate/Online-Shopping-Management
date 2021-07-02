class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :set_current_cart
  before_action :set_current_address
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_current_user
    Current.user = current_user
  end

  def set_current_cart
    Current.cart = Current.user.cart if current_user
  end

  def set_current_address
    address = Current.user.default_address if !Current.user.nil?
    Current.address = address if !address.blank?
  end

  def check_status
    redirect_to users_path, warning: "You are logged in as #{Current.user.email}. Please Log out" if session[:user_id] != nil
  end

  def authenticate_admin_user!
    if Current.user.blank? || Current.user.email != "adminuser@admin.com"
      redirect_to courses_path, danger: "Admin login required"
    end
  end

  def after_sign_in_path_for(users)
    users_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :age, :school, :profile_pic])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :age, :school, :profile_pic])
  end

  add_flash_types :danger, :info, :success, :notice, :warning, :alert
end
