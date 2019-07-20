class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(create_user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        UserMailer.welcome_email(@user.id).deliver_now

        format.html { redirect_to @user, notice: "Your account was successfully created." }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors,
          status: :unprocessable_entity }
      end
    end

  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(edit_user_params)

        format.html { redirect_to @user, notice: "Your account was successfully updated." }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors,
          status: :unprocessable_entity }
      end
    end

  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def create_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def edit_user_params
    params.require(:user).permit(:name, :username)
  end

end
