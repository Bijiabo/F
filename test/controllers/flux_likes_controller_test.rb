require 'test_helper'

class FluxLikesControllerTest < ActionController::TestCase
  setup do
    @flux_like = flux_likes(:one)
  end
=begin
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:flux_likes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end
=end
  test "should create flux_like" do
    assert_difference('FluxLike.count') do
      post :create, flux_like: { flux_id: @flux_like.flux_id, user_id: @flux_like.user_id }
    end

    assert_redirected_to flux_like_path(assigns(:flux_like))
  end
=begin
  test "should show flux_like" do
    get :show, id: @flux_like
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @flux_like
    assert_response :success
  end

  test "should update flux_like" do
    patch :update, id: @flux_like, flux_like: { flux_id: @flux_like.flux_id, user_id: @flux_like.user_id }
    assert_redirected_to flux_like_path(assigns(:flux_like))
  end
=end
  test "should destroy flux_like" do
    assert_difference('FluxLike.count', -1) do
      delete :destroy, id: @flux_like
    end

    assert_redirected_to flux_likes_path
  end
end
