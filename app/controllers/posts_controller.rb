class PostsController < ApplicationController
  def new
  	@post = Post.new
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  	
  end

private
     def post_params
      params.require(:post).permit(:title, :cpu_name, :cooler_name, :motherboard_name, :memory_name, :gpu_name, :storage_name, :case_name, :power_supply_name, :other, :pc_introduction, :value, :tag, :user_id)
    end
end
