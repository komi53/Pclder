class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :create, :update, :destroy]
  def new
  	@post = Post.new
  end

  def index
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}").page(params[:page]).per(15)
    else
      @posts = Post.all.page(params[:page]).per(15)
    end
    @popular_tags = ActsAsTaggableOn::Tag.most_used().page(params[:page]).without_count.per(10)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments
    if params[:keyword]
      @items = RakutenWebService::Ichiba::Item.search(keyword: params[:keyword])
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
      post = Post.new(post_params)
      post.user_id = current_user.id
      if post.save
          redirect_to posts_path
          flash[:succes] = '投稿に成功しました'
      else
          @posts = Post.all
          @post = post
          render 'new'
      end
  end

  def update
      post = Post.find(params[:id])
      if post.update(post_params)
          flash[:succes] = '編集を完了しました'
          redirect_to post_path(post.id)
      else
          @post = post
          render :edit
      end
  end

  def destroy
      post = Post.find(params[:id])
      post.destroy
      redirect_to posts_path
  end

  def search
  # application controllerで生成した@qを利用して検索する
    @q_posts = @q.result(distinct: true).page(params[:page]).per(15)
    render :index
  end

  def ranking
    @posts = Post.find(Favorite.group(:post_id).order('count(post_id) desc').page(params[:page]).per(15).pluck(:post_id))
  end

private
     def post_params
      params.require(:post).permit(:title, :cpu_name, :cooler_name, :motherboard_name, :memory_name, :gpu_name, :storage_name, :case_name, :power_supply_name, :other, :pc_introduction, :value, :tag_list, :post_image, :user_id)
    end
end
