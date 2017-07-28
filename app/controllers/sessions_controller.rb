class SessionsController < ApplicationController
  
    def new
      
    end
    
    def create
      #Cuando trabajamos con logeo, por ejemplo, a ver especificado en el form_for que vamos a trabajar con una
      #sesion, se crea un hash llamado session, con los parametros email, password y otros detalles.
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        #De esta manera le hacemos saber al explorador web que usuario esta logeado.
        session[:user_id] = user.id
        flash[:success] = "You have successfully logged in"
        redirect_to user_path(user)
      else
        #Usamos flash.now cuando redirigimos a la accion new.
        flash.now[:danger] = "There was something wrong with your login information"
        render 'new'
      end
    end
    
    def destroy
      session[:user_id] = nil
      flash[:success] = "You have logged out"
      redirect_to root_path
    end
    
end