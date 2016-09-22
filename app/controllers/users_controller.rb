class UsersController < ApplicationController

	def index 
		@user =  User.all.order('created_at DESC')
	end
	def new
		@user = User.new		
	end
	def create
		@user = User.new(user_params)
		if 	@user.save
			redirect_to :controller => 'Access', :action => 'login'
		else 
			render 'new'
		end
	end
	def edit
		@user = User.find(params[:id])
	end
	def update
		@user = User.find(params[:id])
		if @user.update(params[:user].permit(:username, :password))
			redirect_to @user
		else
			render 'edit'
		end
	end
	def show
		@user= User.find(params[:id])
	end
	def destroy
		@user=User.find(params[:id])
		@user.destroy

		redirect_to root_path
	end
	private
		def user_params
			params.require(:user).permit(:username,:password,:email,:isAdmin)
		end
end
