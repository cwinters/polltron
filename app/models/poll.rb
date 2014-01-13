class Poll < RedisModel
  my_attributes :choice_ids, :id, :name
  my_key 'poll'

  def add_choice(params)
    params[:poll] = record_key
    choice = PollChoice.create!(params)
    choice_ids << choice.id
    store!
    choice
  end

  def get_choices
    keys = PollChoice.to_keys(choice_ids)
    PollChoice.fetch_all(keys)
  end

  # what to do if choice has votes? ignore for now, later reject
  def remove_choice(id)
    choice_ids = choice_ids.reject {|choice_id| id == choice_id}
    store!
    PollChoice.fetch_by_id(id).delete!
  end
end