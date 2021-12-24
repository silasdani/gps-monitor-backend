class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :email, :admin, :manager, :activated
end
