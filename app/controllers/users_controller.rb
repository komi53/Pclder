class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :follows, :followers, :confirm, :leave]
  def index
  end
  def show
  	@user = User.with_deleted.find(params[:id])
    @posts = @user.posts
  end

  def edit
  	@user = User.with_deleted.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
	   redirect_to user_path(@user)
    else
      render :edit
    end
  end
  def search
    @content = params["search"]["content"]
    @users = User.where('(name || at_name) LIKE ?', '%'+@content+'%')
    render :index
  end
  def follows

  end

  def followers

  end
  def confirm

  end
  def leave
    @user = User.find(current_user.id)
    @user.destroy
    redirect_to root_path
  end
  
  private
     def user_params
      params.require(:user).permit(:name, :email, :introduction, :profile_image, :at_name)
    end
end
