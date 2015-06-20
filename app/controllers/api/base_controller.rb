class Api::BaseController < ApplicationController
  include ActionController::ImplicitRender
  respond_to :json
end