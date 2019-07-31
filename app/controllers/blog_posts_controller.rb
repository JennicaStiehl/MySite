class BlogPostsController < ApplicationController
  def index
    @blog_posts = BlogPost.get_all
  end

  def show
    @blog_post = BlogPost.find(params["id"].to_i)
    @blog_posts = BlogPost.get_all
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      flash[:success] = "Your post has been saved!"
      redirect_to blog_posts_path
    else
      flash[:danger] = @blog_post.errors.full_messages
      render :new
    end
  end

  def edit
    @blog_post = BlogPost.find_by(id: params["id"].to_i)
  end

  def update
    if blog_post_params[:id]
      @blog_post = BlogPost.find_by(id: blog_posts_params[:id])
    else
      @blog_post = BlogPost.find_by(id: params[:id])
    end
    if @blog_post.update(blog_post_params)
      flash[:success] = "Your BlogPost has been updated!"
      redirect_to blog_posts_path
    else
      flash[:danger] = @blog_post.errors.full_messages
      @blog_post = BlogPost.find_by(id: params[:id])
      render :edit
    end
  end

  private
  def blog_post_params
    params.require(:blog_post).permit(:title, :summary, :content, :published, :id)
  end
end
