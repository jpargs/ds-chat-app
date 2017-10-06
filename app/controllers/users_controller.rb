class UsersController < ApplicationController
  include ActionView::Helpers::DateHelper


  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = "User <strong>" + @user.full_name + "[" + @user.email + "]</strong> has been successfully registered. Please ask the user to check the Notification Email that has been sent to him/her in order to login on the system."
        log_to_audittrail('add', 'USER', @user.email)

        format.js { render :action => "success" }
        format.html { redirect_to "/" }
    end
  end

  def update
    require_password = 1
    if params[:user][:password].blank?
      require_password = 0
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
      params[:user].delete("current_password")
    end

    @user = User.find(params[:id])
    @user.delete_photo if params[:delete_attachment].present? && params[:delete_attachment][0] == params[:id].to_s

    respond_to do |format|
      if @user.update_attributes(params[:user])
        if @user.id == current_user.id
          flash[:notice] = "Your profile has been successfully updated."
          log_to_audittrail('edit', 'PROFILE', @user.email)

          format.js { render :action => "success_profile" }
          format.html { redirect_to "/admin/profile" }
        else
          flash[:notice] = "User <strong>" + @user.full_name + "[" + @user.email + "]</strong> has been successfully updated."
          log_to_audittrail('edit', 'USER', @user.email)

          format.js { render :action => "success" }
          format.html { redirect_to "/admin/users" }
        end
      else
        format.js { render :action => "error" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    flash[:notice] = "User <strong>" + @user.full_name + "[" + @user.email + "]</strong> has been successfully deleted."
    log_to_audittrail('delete', 'USER', @user.email)

    flash.discard if User.for_datatables(current_user.id).count(1) == 0

    redirect_to "/admin/users"
  end



  private

  def set_lookups
    @roles = Role.active_roles

  end

end
