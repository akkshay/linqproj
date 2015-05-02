class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :name, presence: true
  validates :email, presence: true
  serialize :received
  include Amistad::FriendModel
  has_many :links
end
