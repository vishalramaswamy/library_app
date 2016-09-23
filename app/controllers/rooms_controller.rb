class RoomsController < ApplicationController
  def index
  	@rooms=Room.all
  end
  def show

  end

def new
	@room=Room.new
	end

	def create
		@room=Room.new(room_params)
		if @room.save
			redirect_to @room
		else
			render 'new'
	end
end
	def destroy
	end
	private 
	def room_params
	params.require(:room).permit(:roomno, :size, :location)

end
end