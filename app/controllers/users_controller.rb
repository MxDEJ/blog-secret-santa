class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :email, :set_email, :destroy]
  def index
  end

  def show
  end

  def edit
  end

  def update
  	if @user.update_attributes(user_params)
      flash[:success] = "Updated without a hitch!"
  		redirect_to edit_user_path(@user)
  	else
      flash[:error] = @user.errors.full_messages
  		render "edit"
  	end
  end

  def email

  end

  def set_email
    if !@user.update_attributes(user_params) || user_params[:email].blank?
      flash[:error] = "Nope. You have to enter an email address or we can't be friends."
      render "email"
    else
      flash.clear
      UserMailer.signup_info(@user).deliver
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    @user.destroy
    flash[:success] = "Well, you went removed yourself. Now it's just you against the world."
    redirect_to root_path
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :url, :available)
  	end

    def find_user
      @user = User.find(params[:id])
    end
end