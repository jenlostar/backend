module API
  module V1
    class BaseController < ActionController::Base
      def current_resource_owner
        binding.pry
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
      end
    end
  end
end
