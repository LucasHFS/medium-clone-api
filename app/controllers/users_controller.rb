# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    render :show
  end

  def update
    @user = current_user
    if @user.update(user_params)
      render :show
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :bio, :image_url)
  end
end
