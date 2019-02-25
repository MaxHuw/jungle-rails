class User < ActiveRecord::Base

  has_secure_password

  has_many :review

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    user = where('LOWER(email) = ?', email.downcase.strip)[0]
    user && user.authenticate(password)
  end
  
end
