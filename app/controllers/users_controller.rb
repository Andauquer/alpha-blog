class UsersController < ApplicationController
  
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      #Con esto logeamos al usuario al registrarse por primera vez.
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the alpha blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end
  
  def destroy
    @user.destroy
    flash[:danger] = "User and all articles created by the user have been deleted"
    redirect_to users_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_same_user
    if current_user != @user and !current_user.admin?
      redirect_to root_path
    end
  end
  
  def require_admin
    #Dejo el logged_in? para evitar errores en caso de que se use la barra de urls para acceder a la accion destroy, ya que se genera
    #un error si !current_user.admin? se ejecuta y hay un objeto vacio
    if logged_in? and !current_user.admin?
      redirect_to root_path
    end
  end
  
end