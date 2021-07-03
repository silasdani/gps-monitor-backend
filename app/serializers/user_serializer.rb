class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :password_digest, :remember_digest, :activated

  has_many :tracks
end
