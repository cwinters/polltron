class RedisModel
  def self.create!(params)
    record = new(params)
    record.id = REDIS.incr(record.id_key)
    record.store!
    REDIS.rpush(record.list_key, record.id)
    record
  end

  def self.fetch_by_id(id)
    fetch(to_keys(id).first)
  end

  def self.fetch(key)
    text = REDIS.get(key)
    text ? new(JSON.parse(text)) : nil
  end

  def self.fetch_all(keys)
    REDIS.mget(keys) {|json| new(JSON.parse(json))}.compact
  end

  def self.list
    list_key = new.list_key
    fetch_all(to_keys(REDIS.lrange(list_key, 0, -1)))
  end

  def self.my_attributes(*names)
    define_method(:attributes) {names}
    names.each {|name| attr_accessor name}
  end

  def self.my_key(base)
    define_method(:id_key) do
      "#{base}.id_generator"
    end
    define_method(:list_key) do
      "#{base}.id_list"
    end
    define_method(:record_key) do
      "#{base}.#{self.id}"
    end
  end

  def self.to_keys(*ids)
    ids.map {|id| new(id: id).record_key}
  end

  def initialize(params = {})
    self.attributes.each do |name|
      value = params[name] || params[name.to_s]
      self.send("#{name}=", value) if value
    end
  end

  def delete!
    REDIS.del(record_key)
  end

  def store!
    raise 'Must define ID' unless id
    params = JSON.generate(self.to_h)
    REDIS.set(record_key, params)
    self
  end

  def to_h
    Hash[ self.attributes.map {|name| [name, self.send(name)]} ]
  end

end