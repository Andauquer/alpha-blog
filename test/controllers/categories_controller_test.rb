#Esta linea se añade en todos los archivos test
require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    #Creamos este objeto para probar la ruta show, que necesita un objeto en la base de datos
    #para obtener su id y mostrarlo
    @category = Category.create(name: "sports")
  end
  
  test "should get categories index" do
    #Prueba obtener la pagina :index de categories
    get :index
    #Marca como acierto si lo logra
    assert_response :success
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should get show" do
    #Aunque un poco extraña, esta es la manera de pasar un id para probarlo en este metodo.
    get(:show, {'id' => @category.id})
    assert_response :success
  end
end