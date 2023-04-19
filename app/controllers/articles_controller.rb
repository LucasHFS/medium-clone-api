# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_article!, only: %i[show update destroy]

  def index
    limit = params.fetch(:limit, 20)
    offset = params.fetch(:offset, 0)
    tag = params[:tag]
    author = params[:author]

    @articles = Article.limit(limit).order(created_at: :desc).offset(offset)

    @articles = @articles.authored_by(author) if author

    @articles = @articles.tagged_with(tag) if tag
  end

  def show; end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      render :show, status: :created
    else
      render json: { errors: @article.errors }, status: :unprocessable_entity
    end
  end

  def update
    if user_is_article_author?
      if @article.update(article_params)
        render :show
      else
        render json: { errors: @article.errors }, status: :unprocessable_entity
      end
    else
      render json: { errors: { article: ['Not owned by user'] } }, status: :forbidden
    end
  end

  def destroy
    if user_is_article_author?
      if @article.destroy(article_params)
        render :show
      else
        render json: { errors: @article.errors }, status: :unprocessable_entity
      end
    else
      render json: { errors: { article: ['Not owned by user'] } }, status: :forbidden
    end
  end

  private

  def article_params
    parameters = params.require(:article).permit(:title, :description, :body, tagList: [])
    tag_list = parameters.extract!(:tagList)
    parameters[:tag_list] = tag_list[:tagList]

    parameters
  end

  def set_article!
    @article = Article.find_by!(slug: params[:slug])
  end

  def user_is_article_author?
    current_user.id == @article.user_id
  end
end
