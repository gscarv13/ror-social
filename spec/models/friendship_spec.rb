require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:sent_to_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:sent_to) }
  end
end
