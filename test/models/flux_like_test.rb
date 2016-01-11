require 'test_helper'

class FluxLikeTest < ActiveSupport::TestCase

  def setup
    @user = users(:admin)
    @flux = fluxes(:bijiabobo)
    @flux_like = flux_likes(:one)
  end

  test "should be not valid with no user or flux" do
    assert @flux_like.valid?

    @flux_like.user = nil
    assert_not @flux_like.valid?

    @flux_like.user = @user
    @flux_like.flux = nil
    assert_not @flux_like.valid?
  end

end
