# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  protected

  def after_sign_in_path_for(resource)
    accounts_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
