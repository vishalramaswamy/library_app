class AccessController < ApplicationController


  def manageadmin 
    @access =  User.where(:isAdmin => "true" ).where.not(:username => $globalusername).where.not(:username => "admin").order('created_at DESC')
  end
  def finalbook
    @booked = Booking.select('start_time').where(:booking_date => $globalbookdate).order('start_time')
  end
  def finaladminbook
    @adminbooked = Booking.select('start_time').where(:booking_date => $globaladminbookdate).order('start_time')
  end
  def viewallbooking
    @allbooking = Booking.all
  end
  def viewroomfutureschedule
    @roomfuture = Roomadd.all
  end
  def viewroombookinghistory
    @roomhistory = Roomadd.all
  end
  def viewuserbooking
    @userbooking = User.all
  end
  def admincreatebooking
    @createbooking = Roomadd.all
  end
  def searchroomfutureschedule
    $globalroom_no = params[:room_no]
    @searchresult = Booking.where(:roomnum => $globalroom_no).where("booking_date > ?" , Time.now.to_date)
  end
  def searchroombookinghistory
    $globalroom_no = params[:room_no]
    @searchresult = Booking.where(:roomnum => $globalroom_no).where("booking_date < ?" , Time.now.to_date)
  end
  def searchuserbooking
    $globaluser_name = params[:user_name]
    @searchresult = Booking.where(:name => $globaluser_name)
  end
  def destroybooking
    @access=Booking.find(params[:roomnum])
    @access.destroy
    redirect_to :controller =>'Access' , :action => 'viewallbooking'
  end
  def destroy
    @access=User.find(params[:id])
    @access.destroy
    redirect_to :controller =>'Access' , :action => 'viewmembers'
  end
    def destro
    @access=User.find(params[:id])
    @access.destroy
    redirect_to :controller =>'Access' , :action => 'manageadmin'
  end
    def dest
    @access=Booking.find(params[:roomnum])
    @access.destroy
    redirect_to :controller =>'Access' , :action => 'viewbooking'
  end

  def login
    @access = User.new    

  end
  def viewbooking
    @room=Booking.where(:name => $globalusername)
  end
  def done

  end

def addadmin
@access = User.new
end
def admincreate
  @access = User.new(user_params)
    if  @access.save
      redirect_to :controller => 'Access', :action => 'roomadmin'
    else 
      render 'addadmin'
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
  def admincreatebooking
    @room=Roomadd.all
  end
  def bookadminroomdate
    @userbooking = User.all
    $globaladminroomno=Roomadd.select("room_no").where(:room_no => params[:room_no]).first.room_no
  end
  def bookadminroomtime
    $globaladminbookdate= params[:booking_date]
    $globaladminuser= params[:user_name]
    redirect_to :controller => 'Access', :action => 'finaladminbook'
    end
def finall
$globalbooktime= params[:start_time]
redirect_to :controller => 'Access', :action => 'done'
end
  def finaladmin
    $globaladminbooktime= params[:start_time]
    redirect_to :controller => 'Access', :action => 'admindone'
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

  def editprofileadmin
    @access = User.find($globaluserid)
  end

def updateprofile
    @access = User.find($globaluserid)
    if @access.update(params[:user].permit(:password,:email))
     if User.where(:isAdmin => 'true')
     redirect_to :controller => 'Access', :action => 'roomadmin'
   else
     redirect_to :controller => 'Access', :action => 'roomuser'
   end
#        redirect_to @access
    else
      render 'editprofile'
    end
end
def viewmembers
@access =  User.where(:isAdmin => nil )
end
  def roomuser
    @access = User.find($globaluserid)

  end
  def roomadmin
    @access = User.find($globaluserid)

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
            redirect_to :action => 'login', error: "An error message for the user"
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
    def user_params
      params.require(:user).permit(:username,:password,:email,:isAdmin)
    end
end
