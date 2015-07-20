class HomesController < ApplicationController
  layout "home"
  def index
    if user_signed_in?
      redirect_to user_path(current_user)
    end
  end
end
