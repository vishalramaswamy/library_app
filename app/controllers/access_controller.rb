class AccessController < ApplicationController
  def index
  end

  def manageadmin 
    @access =  User.where(:isAdmin => "true" ).where.not(:username => $globalusername).order('created_at DESC')
  end
  def destroy
    @access=User.find(params[:id])
    @access.destroy
    redirect_to :controller =>'Access' , :action => 'manageadmin'
  end
  def login
#    @access = User.new    

  end
def addadmin
@access = User.new
end
def admincreate
  @access = User.new(access_params)
    if  @access.save
      redirect_to :controller => 'Access', :action => 'roomadmin'
    else 
      render 'new'
    end
  end
  def roomcreate

  end

  def userprofile
    @access = User.find($globaluserid)

  end

  def editprofile
    @access = User.find($globaluserid)
  end

def updateprofile
    @access = User.find($globaluserid)
    if @access.update(params[:user].permit(:password,:email))
     redirect_to :controller => 'Access', :action => 'roomuser'
#        redirect_to @access
    else
      render 'edit'
    end
end

  def roomuser
 #   @access = User.find($globaluserid)

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
            redirect_to(:action => 'roomadmin')
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

  private
    def access_params
      params.require(:user).permit(:username,:password,:email,:isAdmin)
    end
end
