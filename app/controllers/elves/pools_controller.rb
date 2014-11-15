class Elves::PoolsController < Elves::ElvesController

	def show
		@pool = current_tenant
		if params[:filter] && User.valid_scope?(params[:filter])
			@users = User.send(params[:filter]).includes(:giver).order(:name)
		else
			@users = User.includes(:giver).order(:name)
		end
	end
end