class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @achievements = @user.achievements
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    puts "Received params: #{params.inspect}"
    puts "Languages param: #{params[:user][:languages].inspect}"

    if @user.update(user_params)
      puts "Updated user languages: #{@user.languages.inspect}"
      redirect_to @user, notice: 'Profile was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  # Set the user before actions
  def set_user
    @user = User.find_by(id: params[:id])

    return unless @user.nil?

    redirect_to users_path, alert: 'User not found'
  end

  # Allow trusted parameters through
  def user_params
    permitted = params.require(:user).permit(
      :username,
      :first_name,
      :last_name,
      :canton,
      :country_of_origin,
      :avatar,
      languages: []
    )
    puts "Permitted params: #{permitted.inspect}"
    permitted
  end
end
