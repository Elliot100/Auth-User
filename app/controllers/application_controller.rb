class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    #to use this method in any views
    helper_method :current_user

    def log_in!(user)
        #force other client to log out reset session_token
        user.reset_session_token!
        @current_user = user
        #save onto cookie
        self.session[:session_token] = @current_user.session_token
    end

    def log_out!
        current_user.try(:reset_session_token!)
        self.session[:session_token] = nil
    end

    def current_user
        return nil if self.session[:session_token].nil?
        @current_user ||= User.find_by(session_token: self.session[:session_token] )
    end

    # making every page pricate
    def require_current_user!
        redirect_to new_session_url if current_user.nil?
    end
end
