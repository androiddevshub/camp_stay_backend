class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def user_data(token)
    {
      id: id,
      name: name,
      phone: phone,
      email: email,
      token: token,
    }
  end       
end
