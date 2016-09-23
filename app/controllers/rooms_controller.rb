class RoomsController < ApplicationController
  def index
  	@room=Roomadd.all
  end
  def show
@room = Roomadd.find(params[:id])
  end

def new
	@room=Roomadd.new
	end
def edit
@room = Roomadd.find(params[:id])
@room.destroy
end
	def create
		@room=Roomadd.new(room_params)
		if @room.save
			redirect_to rooms_index_path
		else
			render 'new'
	end
end
def update
	@room=Roomadd.find(params[:id])
	temp = @room.update(room_params)
	temp.destroy
	if(temp)
		redirect_to @room
	else
		render 'edit'
	end
end


	def destroy
@room =Roomadd.find(params[:id])
@room.destroy
redirect_to rooms_index_path
	end
	private 
	def room_params
	params.require(:roomadd).permit(:room_no, :size, :location)

end
end