class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:address, :city, :postal_code, :province_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:address, :city, :postal_code, :province_id])
  end

  helper_method :current_cart

  private

  def current_cart
    session[:cart] ||= []
    cart_data = session[:cart]
    cart_data.is_a?(Array) ? Cart.new(cart_data) : Cart.new
  end
end
