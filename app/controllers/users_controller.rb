class UsersController < ApplicationController

  respond_to :html, :xml, :json

  def index
    @users = User.all
    respond_with(@users)
  end

  def new
    @user = User.new
    respond_with @user
  end

  def show
    @user = User.find(params[:id])
    respond_with(@user)
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to :action => "index"
    else
      render :action => 'new'
    end

  end

  def edit
    @user = User.find(params[:id])
    respond_with(@user)
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated product."
    end
    respond_with(@user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed product."
    respond_with(@user)
  end

end
