class PostsController < ApplicationController
    def index
        @posts = Post.includes(:user).all
    end

    def new
        @post= Post.new
    end
    
    def create
        @post = current_user.posts.build(post_params)
        if @post.save
          flash[:notice] = "投稿が作成されました"
          redirect_to posts_path
        else
          flash.now[:alert] = "投稿に失敗しました"
          render :new, status: :unprocessable_entity
        end
    end

    private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
