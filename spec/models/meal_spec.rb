require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe 'Field validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many(:foods) }
    it { should have_many(:meal_foods) }
  end
end
