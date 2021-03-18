require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it 'should validate presence of sent_to'
    it 'should validate presence of status'
  end

  describe 'associations' do
    it 'should belongs to user'
    it 'should belongs to sent_to'
  end
end
