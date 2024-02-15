class BlogsController < ApplicationController
  before_action :set_blog, except: %i[index new create]
  before_action :authorize_role!, except: [:edit, :update]

  def index
    @filtered_blogs = Blog.ransack(params[:search])
    @pagy, @blogs = pagy(policy_scope(@filtered_blogs.result.order(created_at: :desc)))
  end

  def show; end

  def new
    @blog = Blog.new(author: current_user)
  end

  def create
    @blog = Blog.new({**permitted_params, author: current_user})

    respond_to do |format|
      if @blog.save
        format.html { redirect_to blog_path(@blog), notice: 'Successfully Created.' }
      else
        flash[:alert] = @blog.errors.full_messages.join('<br>')
        format.html { redirect_to new_blog_path }
      end
    end
  end

  def edit
    authorize @blog
  end

  def update
    authorize @blog
    set_approved_by
    respond_to do |format|
      if @blog.update(permitted_params)
        format.html { redirect_to blog_path(@blog), notice: 'Successfully Updated.' }
      else
        flash[:alert] = @blog.errors.full_messages.join('<br>')
        format.html { redirect_to new_blog_path }
      end
    end
  end

  private

  def permitted_params
    params.require(:blog).permit(:title, :content, :status, :introduction)
  end

  def set_blog
    @blog = policy_scope(Blog).friendly.find(params[:id])
  end

  def set_approved_by
    if !@blog.published? && permitted_params[:status] == 'published'
      @blog.update(approved_by: current_admin_user)
    end
  end
end
