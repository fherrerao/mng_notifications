# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    # Esto imprimirá en la consola del servidor (donde corre rails s)
    # exactamente lo que Devise está recibiendo.
    puts '=== PARAMETROS RECIBIDOS ==='
    puts params.inspect
    puts '============================'

    # Llamamos al comportamiento normal de Devise
    super
  end

  private

  def respond_with(resource, _opt = {})
    # Verificamos si el recurso (user) existe y si Warden lo autenticó
    if resource.persisted?
      @token = request.env['warden-jwt_auth.token']
      headers['Authorization'] = @token

      render json: {
        status: {
          code: 200, message: 'Logged in successfully.',
          token: @token,
          data: { user: UserSerializer.new(resource).serializable_hash[:data][:attributes] }
        }
      }, status: :ok
    else
      # Si las credenciales fallan, Devise debería entrar por aquí o fallar antes
      render json: {
        status: { code: 401, message: 'Invalid Email or password.' }
      }, status: :unauthorized
    end
  end

  def respond_to_on_destroy(_resource = nil)
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split.last,
                               Rails.application.credentials.devise_jwt_secret_key!).first

      current_user = User.find(jwt_payload['sub'])
    end

    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
