#Esta linea se añade en todos los archivos test
require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  #Cada vez que hagamos una prueba, primero ejecutara este metodo setup y luego el resto
  #de los metodos.
  def setup
    #Todo lo que hamos con las pruebas, no tocaran la BD de desarollo, solo la de prueba.
    @category = Category.new(name: "sports")
  end
  #Este puede ser un nombre cualquiera
  test "category should be valid" do
    #Prueba que se pueda instanciar una variable tipo @category
    #Marca como acierto si la @category.valid? retorna true.
    assert @category.valid?
  end
  
  test "name should be present" do
    #Prueba que la categoria tenga un nombre
    @category.name = " "
    #Marca como acierto si la @category.valid? retorna false.
    assert_not @category.valid?
  end
  
  test "name should be unique" do
    #Prueba que la categoria tenga un nombre unico
    @category.save
    @category2 = Category.new(name: "sports")
    assert_not @category2.valid?
  end
  
  test "name should not be too long" do
    #Prueba que la categoria no tenga un nombre demasiado largo
    @category.name = "a" * 26
    assert_not @category.valid?
  end
  
  test "name should not be too short" do
    #Prueba que la categoria no tenga un nombre demasiado corto
     @category.name = "aa"
     assert_not @category.valid?
  end
  
end