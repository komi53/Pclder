class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
 	protect_from_forgery with: :exception



  def after_sign_in_path_for(resource)
  	root_path
  end

	def after_sign_out_path_for(resource)
		root_path
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :at_name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

  private
  def set_search
    # 検索バー表示のために常に@qを生成する
    # 検索時以外params[:q]はnilだが、空のransackオブジェクト生成の動作になる
    @q = Post.ransack(params[:q])
  end

end
