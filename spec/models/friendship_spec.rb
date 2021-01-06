require 'rails_helper'

RSpec.describe Friendship, type: :model do
  friendship = Friendship.new(user_id: 1, friend_id: 2, status: false)
  it 'Should have the user_id as a column' do
    expect(Friendship.column_names).to include('user_id')
  end

  it 'Should have the friend_id as a column' do
    expect(Friendship.column_names).to include('friend_id')
  end

  it 'Should have the status as a column' do
    expect(Friendship.column_names).to include('status')
  end

  it 'Should not be valid without the user_id' do
    friendship = Friendship.new(user_id: nil)
    expect(friendship).to_not be_valid
  end

  it 'Should not be valid without the friend_id' do
    friendship = Friendship.new(friend_id: nil)
    expect(friendship).to_not be_valid
  end

  it 'Should not be valid without the status' do
    friendship = Friendship.new(status: nil)
    expect(friendship).to_not be_valid
  end
end

RSpec.describe Friendship, type: :model do
  it 'belongs to the user' do
    should belong_to(:user)
  end

  it 'belongs to the friend' do
    should belong_to(:friend).class_name('User')
  end
end
