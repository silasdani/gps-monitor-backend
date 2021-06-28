  class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :password_digest, :remember_digest, :admin, :manager, :activated
  has_many :races
end
