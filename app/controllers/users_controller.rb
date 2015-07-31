class UsersController < ApplicationController
  layout "layout", only: [:show, :list, :account]
  # layout "no-header", only: [:show]
  before_action :authenticate_user!
  # has_attached_file :avatar
  # before_action :find_id, only: [:show, :edit, :update, :destroy]

  def show
    @user = User.find(current_user.id)
    @team_id = @user.team_id
    @role_id = @user.role_id
    @team = Team.find(@team_id)
    @role = Role.find(@role_id)
    @versions = @user.versions.all
    @user.versions.build
  end

  def new
    @user = User.find(params[:id])
  end

  def list
    @user = User.find(current_user.id)
    @teams = Team.all
     @team_id = @user.team_id
    @role_id = @user.role_id
    @team = Team.find(@team_id)
    @role = Role.find(@role_id)
  end

  def account
    @user = User.find(current_user.id)
     @team_id = @user.team_id
    @role_id = @user.role_id
    @team = Team.find(@team_id)
    @role = Role.find(@role_id)
  end

  def create
    @user = User.create(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_path(current_user), notice: "Your CV was successfully uploaded!" }      
      else
        format.html { render 'new', notice: "Upload failed!" }
      end
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(update_params)
      redirect_to @user
    else 
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:cv, :avatar)
  end

  def update_params
    params.require(:user).permit(:username, :address, :phone, :avatar, :region, :gender, :skype)
    # params.require(:user).permit(:cv, versions_attributes: [:comment, :version])

  end
end
