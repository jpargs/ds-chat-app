class LoginController < Devise::SessionsController
  layout 'login'
  
  def new
    super
  end
  
end