require 'test_helper'

class FluxTest < ActiveSupport::TestCase

  def setup
    @user = users(:bijiabobo)
    @flux = @user.fluxes.build(motion: "share_text", content: "Hello,world!", user_id: @user.id)
  end

  test "should be valid" do
    assert @flux.valid?
  end

  test "user id should be present" do
    @flux.user_id = nil
    assert_not @flux.valid?
  end

  test "content should be present" do
    @flux.content = "    "
    assert_not @flux.valid?
  end

  test "content should be at most 140 charaters" do
    @flux.content = "a"*141
    assert_not @flux.valid?
  end

  test "order should be most recent first" do
    assert_equal Flux.first, fluxes(:most_recent)
  end
end
