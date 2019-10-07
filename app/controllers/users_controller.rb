class UsersController < ApplicationController

  def home
    render('home')
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(param[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "The user's #{@user.name_of_file} has been uploaded"
    else
      render('new')
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice:  "The user's #{@user.name_of_file} has been deleted"
  end

  private
  def user_params
    params.require(:user).permit(:name_of_file, :file)
  end
end