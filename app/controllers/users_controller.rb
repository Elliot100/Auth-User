class UsersController < ApplicationController

    def create
        @user = User.new(user_params)

        if @user.save
            # will need to redirect_to :show
            log_in!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def new
        @user = User.new

        render :new
    end

    def show
        if current_user.nil?
            redirect_to :new
            return
        end

        @user = current_user
        render :show
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
end