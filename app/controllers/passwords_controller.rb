class PasswordsController < Devise::PasswordsController
  
  def new
    super
  end
  
  def create
    super
  end
  
  def edit
    super
  end
  
  def update
    super
  end
  
  def after_resetting_password_path_for(resource)
    flash[:notice] = "Password successfully changed!"
    "/"
  end
  def after_sending_reset_password_instructions_path_for(resource_name)
    flash[:notice] = "An email has been sent to your email for instructions!"
    "/"
  end
end