class DrawsController < ApplicationController
  skip_before_action :authenticate, only: :show

  def new
  end

  def show
    @draw = Draw.open.first
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
