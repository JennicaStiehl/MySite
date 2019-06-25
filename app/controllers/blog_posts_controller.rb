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
    @blog_posts = BlogPost.find_by(slug: params[:slug])
  end

  def update
    if blog_posts_params[:slug]
      @blog_posts = BlogPost.find_by(slug: blog_posts_params[:slug])
    else
      @blog_posts = BlogPost.find_by(slug: params[:slug])
    end
    if @blog_posts.update(blog_posts_params)
      flash[:success] = "Your BlogPost has been updated!"
      redirect_to dashboard_blog_posts_path
    else
      flash[:danger] = @blog_posts.errors.full_messages
      @blog_posts = BlogPost.find_by(id: params[:id])
      render :edit
    end
  end

  private
  def blog_post_params
    params.require(:blog_post).permit(:title, :summary, :content, :published)
  end
end
