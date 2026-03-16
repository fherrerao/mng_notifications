class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum role: { regular: 'regular', editor: 'editor', admin: 'admin' }

  validates :role, inclusion: { in: roles.keys }

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :regular
  end
end
