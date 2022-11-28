# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    @user = login(user_params[:email], user_params[:password])
    if @user
      redirect_back_or_to root_url, notice: 'You are now logged in!'
    else
      @user = User.new(user_params)
      flash.now[:alert] = 'Those details are incorrect - please try again!'
      render action: :new
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: 'You are now logged out!'
  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
