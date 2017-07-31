#Esta linea se añade en todos los archivos test
require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  
  def setup
    #Creamos este objeto para probar la ruta show, que necesita un objeto en la base de datos
    #para obtener su id y mostrarlo
    @category = Category.create(name: "sports")
    #Para realizar las pruebas, debemos crear un usuario administrador y logearlo.
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: false)
    session[:user_id] = @user.id
  end
  
  test "should get categories index" do
    #Prueba obtener la pagina :index de categories
    get :index
    #Marca como acierto si lo logra
    assert_response :success
  end
  
  test "should get new" do
    #Marca acierto si un usario logeado lograr acceder a la pagina de nueva categoria.
    get :new
    assert_response :success
  end
  
  test "should get show" do
    #Aunque un poco extraña, esta es la manera de pasar un id para probarlo en este metodo.
    get(:show, {'id' => @category.id})
    assert_response :success
  end
  
  test "should redirect create when admin not logged in" do
    #Sera un acierto si al intentar crear una categoria como un usuario que no esta logeado, o que no es un admin
    #no genera un cambio en la tabla de categorias.
    assert_no_difference 'Category.count' do
      post :create, category: { name: "sports" }
    end
    assert_redirected_to categories_path
  end
end