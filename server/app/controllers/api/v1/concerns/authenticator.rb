module Api
  module V1
    module Concerns
      module Authenticator
        extend ActiveSupport::Concern

        included do
          before_action :auth_with_token!
        end

        # Devise methods overwrites
        def current_user
          @current_user ||=
            User.find_by(auth_token: request.headers['Authorization'])
        end

        def user_signed_in?
          current_user.present?
        end

        def auth_with_token!
          head :unauthorized unless user_signed_in?
        end

        def auth_with_admin_token!
          head :unauthorized unless user_signed_in? && user_is_admin?
        end

        def user_is_admin?
          current_user.present? && @current_user.roles == 'admin'
        end
      end
    end
  end
end
