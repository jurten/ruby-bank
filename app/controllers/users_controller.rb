class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.accessible_by(current_ability)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /staff/new
  def staff_new
    @user = User.new
  end

  # GET /admin/new
  def admin_new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    if user_params[:branch_id] != nil
        user_data = user_params.merge({:role => "staff"})
      else
        user_data = user_params.merge({:role => "admin"})
    end
    @user = User.new(user_data)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "El Usuario fue creado con exito" }
      else
        if user_params[:branch_id] != nil
          format.html { render :admin_new, status: :unprocessable_entity }
        else
          format.html { render :staff_new, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "El Usuario fue actualizado con exito" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "El Usuario fue borrado con exito" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role, :branch_id)
    end
end
