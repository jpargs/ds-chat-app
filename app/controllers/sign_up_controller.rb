class SignUpController < ApplicationController
  layout 'login'
  def index
    @user = User.new
  end
  
  
end