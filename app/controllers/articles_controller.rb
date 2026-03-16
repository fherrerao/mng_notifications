class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_article, only: %i[show update destroy]

  def index
    @articles = Article.all
    render json: @articles
  end

  def show
    render json: @article
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    authorize @article

    if article.save
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @article
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @article
    @article.destroy
    head :no_content
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
