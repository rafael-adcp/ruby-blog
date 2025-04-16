class BlogPostsController < ApplicationController
  # matchin view on /home/rprado_ubuntu/blog/app/views/blog_posts/index.html.erb

  before_action :set_blog_post,
     # except: [ :index, :new, :create ] both ways works
     only: [ :show, :edit, :update, :destroy ]

  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    # @ will share it with the views
    if user_signed_in?
      @blog_posts = BlogPost.sorted
    else
      @blog_posts = BlogPost.published.sorted
    end
  end

  def show
  end

  def new
    # create a new in memory completely empty object, but not save it to db yet
    # so we can give to rails to generate a form
    # a match the form to the db columbs for us
    @blog_post = BlogPost.new
  end

  # params here is:
  # => #<ActionController::Parameters {"authenticity_token" => "REDACTED", "blog_post" => {"title" => "teste 12345", "body" => "78945611"}, "button" => "", "controller" => "blog_posts", "action" => "create"} permitted: false>
  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path
  end

  private
  def blog_post_params
    params.require(:blog_post).permit(:title, :body, :published_at)
  end

  def set_blog_post
    if user_signed_in?
      @blog_post = BlogPost.find(params[:id])
    else
      @blog_post = BlogPost.published.find(params[:id])
    end

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
