class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  #GET /users
  def index
    @user = User.all
  end

  # GET /users/:id
  def show
    @boats = @user.boats.all
    @appointments = @user.appointments.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # Get /users/:id/edit
  def edit
  end

  # POST /users/
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User Successfully created' }
        format.json { render :show, status: :created, location: @hog }
      else
        format.html{ render :new}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end
  # /PATCH/PUT /users/:id
  # /PATCH/PUT /users/:id.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html {redirect_to @user, notice: 'User Successfully updated '}
        format.json {render :show, status: :ok, location: @user }
      else
        format.html {render :edit}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /hogs/1
  # DELETE /hogs/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User Successfully Destroyed'}
      format.json {head :no_content}
    end

  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone,
                                 :password_digest, :password_confirmation)
  end

end
