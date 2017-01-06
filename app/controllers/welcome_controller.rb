class WelcomeController < ApplicationController
  def index
    flash[:notice] = 'welcome to the rails104 success'
    flash[:warning] = 'welcome to the rails104 warning'
    flash[:alert] = 'welcome to the rails104 danger'
  end

end
