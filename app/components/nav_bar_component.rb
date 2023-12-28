class NavBarComponent < ViewComponent::Base
  def initialize(user_signed_in:)
    @user_signed_in = user_signed_in
  end

  attr_reader :user_signed_in
end
