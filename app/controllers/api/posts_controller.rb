class Api::PostsController < Api::BaseController
  skip_before_filter :authenticate_user_from_token!, only: [:index, :show]
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    paginated_content = Post.paginate params
    @posts = paginated_content.result
    @meta = paginated_content.meta
  end

  def show
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.save
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)
    @post.save
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
  end

  def upvote
    @post = Post.select('id, upvotes').find params[:id]
    @post.increment!(:upvotes) if @post
  end

  def downvote
    @post = Post.select('id, downvotes').find params[:id]
    @post.increment!(:downvotes) if @post
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
