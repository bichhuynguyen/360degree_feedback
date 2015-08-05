class UsersController < ApplicationController
  layout "layout", only: [:show, :list, :account, :importuser]
  # layout "no-header", only: [:show]
  before_action :authenticate_user!
  # has_attached_file :avatar
  # before_action :find_id, only: [:show, :edit, :update, :destroy]

  def show
    @user     = User.find(current_user.id)
    @team_id  = current_user.team_id
    @role_id  = current_user.role_id
    @team     = Team.find(@team_id)
    @role     = Role.find(@role_id)
    @versions = current_user.versions.all
    current_user.versions.build
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
    @teams    = Team.all
    # @group    = params[:team_id]
    @group    = params[:team_id]
    @members  = User.where(team_id: @group).all
 
    @team_id  = current_user.team_id
    @role_id  = current_user.role_id
    @team     = Team.find(@team_id)
    @role     = Role.find(@role_id)
  end

  def account
    @user     = User.find(current_user.id)
    @team_id  = current_user.team_id
    @role_id  = current_user.role_id
    @team     = Team.find(@team_id)
    @role     = Role.find(@role_id)
  end

  def team
    @user     = User.find(current_user.id)
    @teams    = Team.all
    @team_id  = current_user.team_id
    @role_id  = current_user.role_id
    @team     = Team.find(@team_id)
    @role     = Role.find(@role_id)
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
    # @user = User.find(current_user.id)
  end

  def update
    @previousVersion = Version.last
    @ver = @previousVersion.version
    # Version.version = @ver + 0.1


    if current_user.update(update_params)
      redirect_to current_user
    else 
      render 'edit'
    end
  end

  def importuser
    @users = User.all
    @roles = Role.all
    @teams = Team.all
    @user = User.find(current_user.id)
    @team_id = @user.team_id
    @role_id = @user.role_id
    @team = Team.find(@team_id)
    @role = Role.find(@role_id)
    # require 'csv'
    # respond_to do |format|
    #   format.csv { send_data @users.to_csv }
    #   format.html
    # end
  end

  def import
    User.import(params[:file])
    redirect_to users_importuser_path, notice: "Users imported success."
  end

  private

  def user_params
    params.require(:user).permit(:cv, :avatar, :username, :user_code)
  end

  def update_params

    params.require(:user).permit(:username, :address, :phone, :avatar, :region, :gender, :skype)
    # params.require(:user).permit(:cv, versions_attributes: [:comment, :version])

    # params.require(:user).permit(:username, :address, :phone, :password, :avatar)
    params.require(:user).permit(:cv, versions_attributes: [:comment, :version])

  end
end
