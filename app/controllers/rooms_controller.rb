class RoomsController < ApplicationController
	def index
		@rooms = current_user.rooms.joins(:chats).includes(:chats).order("chats.created_at DESC")
	end

end
