class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if(@user.save)
      session[:user_id] = @user.id 
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username} ! You have successfully signed-up an account! "
      redirect_to articles_path
    else
      render 'new' # new.html.erb
    end
  end

  def edit
  end

  def update
    if (@user.update(user_params))
      flash[:notice] = "User profile updated successfully!"
      redirect_to user_path
    else
      render 'edit' #edit.html.erb
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
