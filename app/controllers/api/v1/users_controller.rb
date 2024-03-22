module Api 
    module V1 
        class UsersController < ApplicationController
            def index
                @users = User.all

                render json: {data: @users}
            end
        end
    end
end