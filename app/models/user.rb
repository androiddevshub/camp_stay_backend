class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  enum role: ["admin", "tourist", "camp_owner"]
  has_many :camps

  def user_data(token)
    {
      id: id,
      name: name,
      phone: phone,
      email: email,
      role: role,
      token: token,
    }
  end       
end
