class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def admin?
    role == "admin"
  end

  def member?
    role == "member"
  end

  def super_admin?
    role == "super_admin"
  end


  #used by rails_admin to limit values for role field
  def role_enum
    [ 'admin', 'member']
  end

end
