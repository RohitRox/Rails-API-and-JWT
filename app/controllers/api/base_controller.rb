class Api::BaseController < ApplicationController
  include ActionController::ImplicitRender
  respond_to :json

  protected

  def render_unauthorized(payload)
    render json: payload.merge(response: { code: 401 })
  end

end
