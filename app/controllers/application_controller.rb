class ApplicationController < ActionController::API
        before_action :configure_permitted_parameters, if: :devise_controller?
        # protect_from_forgery with: :exception, unless: -> { request.format.json? }
        include DeviseTokenAuth::Concerns::SetUserByToken

        protected

        def configure_permitted_parameters
                devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :image])
        end
end
