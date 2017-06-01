class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  self.inheritance_column = 'class_name'

  before_validation :create_password, on: :create

  has_many :mailboxes, dependent: :destroy
  has_many :emails, through: :mailboxes, dependent: :destroy
  has_many :authored_emails, class_name: 'Email', dependent: :destroy

  def username
    email.split('@').first
  end

  def admin?
    class_name == 'AdminUser'
  end

  private

  def create_password
    self.password = SecureRandom.hex if password.nil?
  end
end
