class SessionsController < ApplicationController
    def create
        user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )

        if user
            #login the user
            log_in!(user)
            redirect_to user_url(user)
        else
            #no such user in db
            flash.now[:errors] ||= []
            flash.now[:errors] << "sorry credentials are bad"
            render :new
        end
    end

    def destroy
        # log out
        log_out!
        redirect_to new_session_url
    end

    def new
        #present new form
        render :new
    end
end