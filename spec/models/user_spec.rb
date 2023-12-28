require 'rails_helper'

RSpec.describe User, type: :model do
  context "validation" do
    it { is_expected.to validate_presence_of(:email)}
    it { is_expected.to validate_presence_of(:encrypted_password)}
  end
end
