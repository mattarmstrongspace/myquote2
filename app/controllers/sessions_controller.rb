class SessionsController < ApplicationController
    
    #rendering the associated view containing the login form html
    def new 

    end

    #create method to handle the loging process 
    def create

        # attempting to find the user in the database by the provided email
        user = User.find_by(email: params[:email]) 

        #if found, check the submitted password and if the status is set to active. if correct, user_id, fname and is_adminassigned to session object
        if user && user.authenticate(params[:password]) &&user.status == "Active"
            session[:user_id] = user.id
            session[:fname] = user.fname
            session[:is_admin] = user.is_admin

            #validated users are redirected to paths that apply to them, whether they are admin
            if session[:is_admin]
                redirect_to admin_path, notice: "Logged in successfully!"
            
            else
                redirect_to userhome_path, notice: "Logged in successfully!"
            end
        
        else
            #if authetnication fails, error message displays and login form is re rendered
            flash.now[:error] = "Invalid email or password. Please try again."
            render 'new'
        end
    end

    #destroy method to handle the logout process , clearing all parameters from session object and rendering it nil, sending user to home page
    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged out successfully!"
    end
end
