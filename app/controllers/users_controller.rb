class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.all

    authorize User.new
  end

  def show
    @user = User.find(params[:id])

    authorize @user
  end

  def edit
    @user = User.find(params[:id])

    authorize @user
  end

  def update
    @user = User.find(params[:id])

    authorize @user

    if @user.update_attributes(secure_params)
      redirect_to admin_admins_index_path, :notice => I18n.t("user.messages.updated", name: @user.name)
    else
      flash[:alert] = "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role, :email, :name, :course_grants)
  end

end
