class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  #By defining controller methods as helper methods, the logic becomes available to corresponding views
  helper_method :current_user, :logged_in?, :is_administrator?

  #current_user method retreivesdetails of logged in user from session opject, assigning details to @current_user, so database is only queried once per requested
  def current_user
    @current_user || User.find_by(id: session[:user_id])
  end
  
  #logged_in? method checks if the user is loggedin, if the method returns not nil, user is determined to be loged in
  def logged_in?
    !current_user.nil?
  end

  #is_adminstrator? method checksif currentuser is admin based on setting of sessions[]:is_admin] value.if true, user is admin, otherwise, standard user
  def is_administrator?
    session[:is_admin]
  end

  #Setting all methods that follow to private, preventing from being called outside ApplicationController.
  private

    #require_login ensures that the actions or controller iso only accessible by logged in users, if not logged in, send an error message and redirect user to login page
    def require_login
      unless logged_in?
      flash[:error] = "You are not permitted to access this resource"
      redirect_to login_path
      end
    end
end
