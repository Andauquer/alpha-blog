class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:idex, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    #De esta manera especificamos la paginacion en el muestro de articulos
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end
  
  def new
    @article = Article.new
  end
  
  def edit
  end
  
  def create
     @article = Article.new(article_params)
     @article.user = User.first
     if @article.save
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
     else
      render 'new'
     end
  end
  
  def update
     if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
     else
      render 'edit'
     end
  end
  
  def show
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end
  
  private
  
  def set_article
    @article = Article.find(params[:id])
  end
  
  def article_params
    params.require(:article).permit(:title, :description)
  end
  
  def require_same_user
    #Tenemos accesos a @article.user porque tenemos un before_action que lo setea con
    #anticipacion.
    if current_user != @article.user
      redirect_to root_path
    end
  end
  
end