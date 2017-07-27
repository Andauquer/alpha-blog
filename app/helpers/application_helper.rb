module ApplicationHelper
  #Segun la documentacion de Gravatar, esta es la manera en que vinculamos nuestro sitio web con su servicio.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    #Recordemos que img_circle es una de las clases de bootstrap
    image_tag(gravatar_url, alt: user.username, class: "img-circle")
  end
end
