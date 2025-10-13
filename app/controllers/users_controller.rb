class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_login, except: [:new, :create] #only new and create methods can be called by non-logged in users

  # GET /users or /users.json
  def index
   # @users = User.all
    # if there is a logged in user and is also an admin
    if logged_in? && is_administrator?
      #retreieve all users from database
      @users = User.all
    #otherwise, send to user landing page
    elsif logged_in? &&!is_administrator?
      redirect_to userhome_path
    #otherwise,if no on is logged in, generate unauthorized messgeed, redirect to login page
    else
      flash[:error] = "You are not authorized to access this resource."
      redirect_to loging_path
    end
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # format.html { redirect_to @user, notice: "User was successfully created." }
        format.html {redirect_to login_path, notice: "Sign up successful! Please log in."}
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to userhome_path, notice: "User was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through, ensuring that the passwordfield is set as an allowed parameter in user controloler
    def user_params
      params.expect(user: [ :fname, :lname, :email, :password, :is_admin, :status ])
    end
end
