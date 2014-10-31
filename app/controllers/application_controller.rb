class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_filter { flash.discard if request.xhr? }

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end

  def after_sign_in_path_for(resource)
    topics_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

end
