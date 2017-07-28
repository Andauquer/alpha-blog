class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #Al crear esta linea de codigo, estos dos metodos estaran disponibles para nuetros views.
  helper_method :current_user, :logged_in?
  
  def current_user
    #Este metodo retornara el objeto usuario que este definido en el hash session. Si existe.
    #Si el objeto current_user ya existe, con esta linea de codigo se evita hacer llamados a la BD cada vez
    #que llamemos al metodo current_user.
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    #Con !!, convertimos el retorno de current_user a booleano. Si current_user existe retornara
    #true, de lo contrario, retornara false.
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
