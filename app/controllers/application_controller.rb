class ApplicationController < ActionController::API
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  end

  private

  def user_not_authorized
    render json: { error: 'No tienes permiso para realizar esta acción' }, status: :forbidden
  end
end
