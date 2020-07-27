class RoomsController < ApplicationController
	before_action :authenticate_user!
	def index
		@rooms = current_user.rooms.joins(:chats).includes(:chats).order("chats.created_at DESC")
	end
	def deleted
	end

end
