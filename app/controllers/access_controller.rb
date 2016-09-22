class AccessController < ApplicationController
  def index
  end

  def login
    @user = User.new    

  end

  def attempt_login
authorized_user=false
admin_user=false
    if params[:username].present? && params[:password].present?
      found_user= User.where(:username => params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      if authorized_user
        if params[:isAdmin]
          admin_user = User.select("isAdmin").where(:username => params[:username]).first
          if admin_user.isAdmin != nil
            redirect_to(:action => 'index')
          else
            redirect_to(:action => 'login')
          end
        else
          redirect_to(:action => 'index')
        end
      else
        redirect_to(:action => 'login')
      end
    else
      redirect_to(:action => 'login')
    end
else
          redirect_to(:action => 'login')

   end
end
  def logout
flash[:notice] = "Log out"
    redirect_to(:action => 'login')
  end
end
