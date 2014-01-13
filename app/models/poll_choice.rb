class PollChoice < RedisModel
  my_attributes :id, :name, :poll
  my_key 'poll_choice'
end