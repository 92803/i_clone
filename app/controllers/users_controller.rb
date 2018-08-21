class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to sessions_path(@user.id)
      flash[:notice] = '＞登録完了、ログインできます'
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation,:icon)
  end
end
