# frozen_string_literal: true

module ResponseHandler
  def success(message=I18n.t('general.success'), data = {}, key = '')
    render json: {
      status: {
        code: 200,
        message:,
        data:,
        key:
      }
    }, status: :ok
  end

  def failure(message = I18n.t('errors.exceptions.not_found'), code = 400, data={}, key = '')
    render json: {
      status: {
        code:,
        message:,
        data:,
        key:
      }
    }, status: :bad_request
  end

  def unprocessable(message = I18n.t('errors.exceptions.unprocessable'), key = '')
    render json: {
      status: {
        code: 422,
        message:,
        key:
      }
    }, status: :unprocessable_entity
  end
end
