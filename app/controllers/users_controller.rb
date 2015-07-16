class UsersController < ApplicationController
  layout "layout"
  before_action :authenticate_user!
  def show
  end

  def update

  end
end
