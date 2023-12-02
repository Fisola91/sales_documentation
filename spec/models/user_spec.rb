require 'rails_helper'

RSpec.describe User, type: :model do
  context "associations" do
    it { is_expected.to have_many(:credentials) }
  end

  context "validation" do
    it { is_expected.to validate_presence_of(:username) }
  end
end