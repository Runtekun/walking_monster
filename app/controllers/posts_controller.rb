class PostsController < ApplicationController
    def index
        @posts = Post.includes(:user)
    end

    def new
        @post= Board.new
    end

    def create
        @post = current_user.boards.build(post_params)
        if @post.save
          redirect_to posts_path, success: ("%{item}を作成しました", item: post.model_name.human)
        else
          flash.now[:danger] = ("%{item}を作成出来ませんでした", item: post.model_name.human)
          render :new, status: :unprocessable_entity
        end
    end

    private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
