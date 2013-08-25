class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @subscriptions = @user.subscriptions
    @count = @subscriptions.count
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    if @user.save
      redirect_to @user
    else
      redirect_to :back
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user
    else
      redirect_to new_user_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

end
