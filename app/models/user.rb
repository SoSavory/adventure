class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
          :rememberable, :trackable

  has_many :stories
  has_many :families, through: :family_user

  has_many :story_favorites
  has_many :user_favorites

end
