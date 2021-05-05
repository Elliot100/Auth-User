class UsersController < ApplicationController

    def create
        @user = User.new(user_params)

        if @user.save
            # will need to redirect_to :show
            render json: @user
        else
            render :new
        end
    end

    def new
        @user = User.new

        render :new
    end

    def show
        
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end