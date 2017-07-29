#Esta linea se añade en todos los archivos test
require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  test "get new category form and create category" do
    #Debemos emular por completo las acciones del usuario, siendo la primera el llamado
    #get de crear una nueva categoria.
    get new_category_path 
    #Marca acierto si puede obtener esta ruta.
    assert_template 'categories/new'
    #Marca acierto si despues de la accion ejecutada en el do, hay una diferencia de 1
    #registro mas en la BD de categorias, es decir, se guardo la nueva categoria.
    assert_difference 'Category.count', 1 do
      #Marca acierto si se logra enviar via post, la nueva categoria. Es decir, si la accion
      #create, se ejecuta exitosamente.
      post_via_redirect categories_path, category: {name: "sports"}
    end
    #Marca acierto si se logra mostrar la pagina index, de categorias.
    assert_template 'categories/index'
    #Maraca acierto si se encuentra la palabra sports en la pagina de index.
    assert_match "sports", response.body
  end
  
  test "get new category form and create category" do
    #Debemos emular por completo las acciones del usuario, siendo la primera el llamado
    #get de crear una nueva categoria.
    get new_category_path 
    #Marca acierto si puede obtener esta ruta.
    assert_template 'categories/new'
    #Marca acierto si despues de la accion ejecutada en el do, hay una diferencia de 1
    #registro mas en la BD de categorias, es decir, se guardo la nueva categoria.
    assert_difference 'Category.count', 1 do
      #Marca acierto si se logra enviar via post, la nueva categoria. Es decir, si la accion
      #create, se ejecuta exitosamente.
      post_via_redirect categories_path, category: {name: "sports"}
    end
    #Marca acierto si se logra mostrar la pagina index, de categorias.
    assert_template 'categories/index'
    #Maraca acierto si se encuentra la palabra sports en la pagina de index.
    assert_match "sports", response.body
  end
  
  test "invalid category submission results in failure" do
    get new_category_path 
    assert_template 'categories/new'
    #Para este caso, se marca acierto si no hay cambios en la tabla categorias.
    assert_no_difference 'Category.count' do
      #Probamos con un nombre vacio, lo cual debe ser invalido.
      #Se quita el _via_redirect ya que en realidad solamente se esta cargando de nuevo la misma pagina,
      #aunque de haberse dejado, se supone que no deberia haber error.
      post categories_path, category: {name: " "}
    end
    assert_template 'categories/new'
    #Se marca acierto si en categories/new, al ser cargado nuevamente tras un intento fallido,
    #se logra seleccionar un h2 con nombre de clase panel-title, y un div con nombre de clase panel-body,
    #los cuales son elementos del parcial _erros.html.erb que se renderiza al producirse un error.
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end