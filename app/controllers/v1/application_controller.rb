# -*- encoding : utf-8 -*-

class V1::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def authenticate_user
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by_access_token(token)
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
