class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ActionView::Helpers::TextHelper

  helper_method :current_user, :current_admin?, :current_reguser?

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_reguser?
    current_user && current_user.default?
  end

  def visitor_or_user
    render file: 'public/404', status: 404 unless current_user.nil? || current_reguser?
  end

  def require_reguser
    render file: 'public/404', status: 404 unless current_reguser?
  end

  def require_admin
    render file: 'public/404', status: 404 unless current_admin?
  end
end
