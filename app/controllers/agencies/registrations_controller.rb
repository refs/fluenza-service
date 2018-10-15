# -*- encoding : utf-8 -*-

module Agencies
  class RegistrationsController < Devise::RegistrationsController
    def create
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :manager_name])
      super
      create_user_along_agency
    end

    private

    def create_user_along_agency
      user = User.new(email: params.require(:agency).permit!.to_h[:email],
                      name: params.require(:agency).permit!.to_h[:name],
                      password: Devise.friendly_token.first(8),
                      agency: Agency.last)
      user.save && sign_in(:user, user)
    end
  end
end
