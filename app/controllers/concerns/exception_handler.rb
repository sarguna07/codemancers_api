module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :internal_server_error
    rescue_from ArgumentError,
                InvalidParams,
                ActionController::ParameterMissing, with: :invalid_params
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
    rescue_from Unauthorized, with: :unauthorized
  end

  def unauthorized
    render json: {
      status: false, message: 'Access Denied'
    }, status: :unauthorized
  end

  def invalid_record(exception)
    render json: {
      status: false,
      message: 'Failed to save record',
      data: exception.message
    }, status: :unprocessable_entity
  end

  def return_404
    render json: {
      status: false,
      message: 'URL Not Found'
    }, status: :not_found
  end

  def internal_server_error
    render json: {
      status: false,
      message: 'Internal Server Error'
    }, status: :internal_server_error
  end

  def invalid_params(exception)
    render json: {
      status: false,
      message: 'Invalid data',
      data: [exception.message]
    }, status: :unprocessable_entity
  end
end
