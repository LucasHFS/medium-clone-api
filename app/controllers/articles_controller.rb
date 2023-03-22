# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authenticate_user!
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      render :show, status: :created
    else
      render json: { errors: @article.errors }, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body, tagList: [])
    # tag_list = parameters.extract!(:tagList)
    # parameters[:tag_list] = tag_list[:tagList]
  end
end
