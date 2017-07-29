require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "books")
    @category2 = Category.create(name: "programming")
  end
  
  test "should show categories listing" do
    get categories_path
    assert_template 'categories/index'
    #Estas dos lineas siguientes, marcaran acierto, si en la pagina 'categories/index' existen dos links, con el texto del nombre 
    #de las categorias, y que lleven a su respectivo show page.
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
  

end