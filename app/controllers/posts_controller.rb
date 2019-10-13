class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]



  # GET /posts
  # GET /posts.json
  def index
    # @posts = Post.page(params[:page]).per(PER).order(created_at: "DESC")
    @pickup_posts =  Post.where(pick_up: true)
    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(:tags).page(params[:page]).per(PER).order(created_at: "DESC")
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

  end

  def tag
    @tag = Tag.find_by(id: params[:tag])
    @posts = @tag.posts.page(params[:page]).per(PER).order(created_at: "DESC")
    @pickup_posts =  Post.where(pick_up: true)
  end

  def pick_up
    @posts=Post.all.order(created_at: "DESC")
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(
      title:post_params[:title],
      content:post_params[:content],
      image_name: post_params[:image_name])
    tag_list = post_params[:tag_list].split(',')
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: '投稿できました' }
        format.json { render :show, status: :created, location: @post }
        @post.save_posts(tag_list)
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update

    tag_list = post_params[:tag_list].split(',')
    respond_to do |format|
      if @post.update(title:post_params[:title],
        content:post_params[:content],
        image_name: post_params[:image_name],
        user_id: post_params[:user_id])
        format.html { redirect_to @post, notice: '編集できませんでした' }
        format.json { render :show, status: :ok, location: @post }
        @post.save_posts(tag_list)
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pick_up_update
    for i in Post.all.ids do
      @post=Post.find_by(id: i)
      @post.update(pick_up: params[:params][:pick_up][i.to_s])
    end
    redirect_to("/")
    # ①全部確認
    # render plain: params.inspect
    # ②特定値のみ確認
    # render plain: params[:params][:pick_up]["25"].inspect
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :image_name, :content, :tag_list)
    end
end
