class UsersController < ApplicationController
  layout "layout", only: [:show, :list, :account]
  # layout "no-header", only: [:show]
  before_action :authenticate_user!
  def show
    @user = User.find(current_user.id)
  end

  def new
    @user = User.find(params[:id])
  end

  def list
    @user = User.find(current_user.id)
  end

  def account
    @user = User.find(current_user.id)
  # if params[:search]
  #     @books  = User.search(params[:search]).where("user_code = 'uploaded book'").order("title ASC").paginate(:page => params[:page], :per_page => 12)
  #   else
  #     @books  = Book.where("kind = 'uploaded book'").order("title DESC").paginate(:page => params[:page], :per_page => 12)
  #     @gbooks = Book.where("kind = 'google book'").order("title DESC").paginate(:page => params[:page], :per_page => 12)
  #   end   
  end

  def create
    @user = User.create(user_params)
    respond_to do |format|
      if @book.save
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
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to user_path(current_user), notice: "Your CV was successfully updated." }
      else
        format.html { redirect_to user_path(@user) , notice: "Update failed." }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:cv)
  end
end
