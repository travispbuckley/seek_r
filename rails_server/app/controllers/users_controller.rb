class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    @user = User.new
  end

  def create
    p params
    p 'http post request made to users create'
    @user = User.new(username:params[:name],password:params[:password],role:'user')
    if @user.save
      session[:user_id] = @user.id
    else
      p @user.errors.full_messages
      @errors = @user.errors.full_messages
    end
  end

  def show
    @user = User.find(params[:id])
    @categories = Category.all
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.role == 'user' ? @user.role = 'admin' : @user.role = 'user'
    @user.save
    respond_to do |format|
        format.html { redirect_to @user }
    end
  end

  private
end
