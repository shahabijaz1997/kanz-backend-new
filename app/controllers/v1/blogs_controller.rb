# frozen_string_literal: true
module V1
  class BlogsController < ApiController
    include PagyHelper
    skip_before_action :authenticate_user!
    before_action :search_params, only: %i[index]

    def index
      @pagy, @blogs = pagy(Blog.published.ransack(params[:search]).result, items: 9)
      render json: {
        blogs: BlogSerializer.new(@blogs, { params: { detailed: false }}).serializable_hash[:data].map{ |object| object[:attributes]},
        pagination: pagy_attributes(@pagy)
      }
    end

    def show
      @blog = Blog.published.friendly.find_by(slug: params[:id])
      if @blog.present?
        render json: {
          transactions: BlogSerializer.new(@blog).serializable_hash[:data][:attributes]
        }
      else
        failure(I18n.t('blog.not_found'), 404)
      end
    end
  end
end