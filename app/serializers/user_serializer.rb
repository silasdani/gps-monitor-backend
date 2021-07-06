class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :email, :password_digest, :admin, :manager, :remember_digest, :activated

  has_many :tracks
end
