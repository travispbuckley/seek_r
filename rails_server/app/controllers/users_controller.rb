class UsersController < ApplicationController

  skip_before_action :verify_authenticity_token

  def new
    @user = User.new
  end

  def create
            # p params
            # p 'http post request made to users create'
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render :json => { session: session }.to_json, status: :created, :message => "TEAM SPIRIT!"
    else
      @errors = @user.errors.full_messages
      render :json => { errors: @errors }.to_json, status: :unprocessable_entity
    end
  end

  # def show
  #   @user = User.find(params[:id])
  #   # @categories = Category.all
  #   @users = User.all
  # end

  def update
    @user = User.find(params[:id])
    @user.save
    # respond_to do |format|
    #     format.html { redirect_to @user }
    # end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
