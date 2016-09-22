class AccessController < ApplicationController
  def index
  end

  def login
#    @user1 = User.new    

  end
  def userprofile
    @user1 = User.find($globaluserid)

  end
def update
    @user1 = User.find($globaluserid)
    if @user1.update(params[:user].permit(:password,:email))
      link_to :controller => 'Access', :action => 'roomuser'
    else
      render :controller => 'Access', :action => 'edit'
          end
end

  def roomuser
 #   @user1 = User.find($globaluserid)

  end
  def edit
    @user1 = User.find($globaluserid)
  end


  def attempt_login
authorized_user=false
admin_user=false
    if params[:username].present? && params[:password].present?
      found_user= User.where(:username => params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
        $globaluserid=User.select("id").where(:username => params[:username]).first.id
$globalusername=User.select("username").where(:username => params[:username]).first.username
      if authorized_user
        if params[:isAdmin]
          admin_user = User.select("isAdmin").where(:username => params[:username]).first
          if admin_user.isAdmin != nil
            redirect_to(:action => 'index')
          else
            redirect_to(:action => 'login')
          end
        else
          redirect_to(:action => 'roomuser')
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
