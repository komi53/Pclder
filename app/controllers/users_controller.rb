class UsersController < ApplicationController
  def index
  end
  def show
  	@user = User.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	@user.update(user_params)
	  redirect_to root_path
  end
  def search
    @content = params["search"]["content"]
    @users = User.where('name LIKE ?', '%'+@content+'%')
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
