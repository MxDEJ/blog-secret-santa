class Santa::GroupsController < Santa::SantaController
	before_action :find_group_by_token, only: [:show, :edit, :update]

	def index
		@groups = Group.includes(:users)
	end

	def show
		if params[:filter] && User.valid_scope?(params[:filter])
			@users = User.send(params[:filter]).includes(:giver).where(group: @group).order(:name)
		else
			@users = User.includes(:giver).where(group: @group).order(:name)
		end
	end

	def new
		@group = Group.new
	end

	def create
		@group = Group.new(group_params)
		if @group.save
			flash[:success] = "#{@group.name} has been created."
			redirect_to edit_group_path(@group)
		else
			flash_errors(@group, true)
			puts flash.inspect
			render :new
		end
	end

	def edit
	end

	def update
		if @group.update(group_params)
			flash[:success] = "Those updates have been saved"
			redirect_to edit_group_path(@group)
		else
			flash_errors(@group, true)
			puts flash.inspect
			render :edit
		end
	end

	private

		def find_group_by_token
			@group = Group.find_by(token: params[:id])
		end

		def group_params
			params.require(:group).permit(:name, :subdomain, :status)
		end
end