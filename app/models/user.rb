class User < RedisModel
  my_attributes :email, :id, :name
  my_key 'user'
end