class CountersController < ApplicationController
    def update
        current_user.counter = params[:user][:counter]

        if current_user.save
            redirect_to user_url
        else
            render json: "bad counter value"
        end
    end
end