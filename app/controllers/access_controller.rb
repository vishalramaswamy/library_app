class AccessController < ApplicationController


  def manageadmin 
    @access =  User.where(:isAdmin => "true" ).where.not(:username => $globalusername).order('created_at DESC')
  end
  def finalbook
    @booked = Booking.select('start_time').where(:booking_date => $globalbookdate).order('start_time')
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

def bookroomtime
$globalbookdate= params[:booking_date]
redirect_to :controller => 'Access', :action => 'finalbook'
#@bookingobject=Booking.new(:booking_date => bookdate, :name => $globalusername, :roomnum => $globalroomno)
#if @bookingobject.save
#  redirect_to :controller => 'Access', :action => 'roomadmin'
#else
#  redirect_to :controller => 'Access', :action => 'viewroomdetailsbyuser'
#end
end
  def bookroomdate
  $globalroomno=Roomadd.select("room_no").where(:room_no => params[:room_no]).first.room_no
  end


  def roomcreate

  end
  def userprofilebyuser
@access = User.find($globaluserid)
  end
def viewroomdetailsbyuser
@room=Roomadd.all
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
     if $globaladminuser.isAdmin != nil
     redirect_to :controller => 'Access', :action => 'roomadmin'
   else
     redirect_to :controller => 'Access', :action => 'roomadmin'
   end
#        redirect_to @access
    else
      render 'edit'
    end
end
def viewmembers
@access =  User.all
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
          $globaladminuser=User.select("isAdmin").where(:username => params[:username]).first
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
