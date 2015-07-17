class HomesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to :controller => 'user', :action => 'show'
    end
  end
end
