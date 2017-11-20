module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :email, :auth_token, :roles
    end
  end
end
