class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :password_digest, :admin, :manager, :activated

  has_many :tracks
end
