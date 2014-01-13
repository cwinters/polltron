require 'test_helper'

class PollTest < ActiveSupport::TestCase
  test 'it should refuse to store with no ID' do
    assert_raise(RuntimeError) {Poll.new(name: 'Some poll').store!}
  end

  test 'it should create! and be fetchable after' do
    p = Poll.create!(name: 'Some other poll')
    assert_equal(p, Poll.fetch_by_id(p.id))
  end

  test 'it should create! and be in the list after' do
    created = Poll.create!(name: 'An awesome poll')
    assert Poll.list.any? {|poll| poll.id == created.id }
  end
end