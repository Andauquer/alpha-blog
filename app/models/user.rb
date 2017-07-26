class User < ActiveRecord::Base
  #uniqueness, en conjunto con la validacion entre llaves, verifica que no exista otro nombre repetido
  #en la base de datos, sin distinguir mayusculas y minusculas.
  validates :username, presence: true, uniqueness: { case_sensitive: false }, 
             lenght: { minimum: 3, maximum: 25 }
  #Esta es una expresion regular para validar el formato que deberia tener un email.
  VALID_EMAIL_REGEX: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, 
             lenght: { maximum: 105 }, format: { with: VALID_EMAIL_REGEX }
end