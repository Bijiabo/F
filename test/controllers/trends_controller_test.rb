require 'test_helper'

class TrendsControllerTest < ActionController::TestCase
  setup do
    @trend = trends(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trends)
  end

  test "should get new" do
    assert_raises(ActionController::UrlGenerationError) do
      get :new
    end
  end

  test "should create trend" do
    assert_raises(ActionController::UrlGenerationError) do
      assert_difference('Trend.count') do
        post :create, trend: { content: @trend.content, flux: @trend.flux, from_cat_id: @trend.from_cat_id, from_user_id: @trend.from_user_id, to_cat_id: @trend.to_cat_id, to_user_id: @trend.to_user_id, type: @trend.type }
      end
    end
  end

  test "should show trend" do
    assert_raises(ActionController::UrlGenerationError) do
      get :show, id: @trend
    end
  end

  test "should get edit" do
    assert_raises(ActionController::UrlGenerationError) do
      get :edit, id: @trend
    end
  end

  test "should update trend" do
    assert_raises(ActionController::UrlGenerationError) do
      patch :update, id: @trend, trend: { content: @trend.content, flux: @trend.flux, from_cat_id: @trend.from_cat_id, from_user_id: @trend.from_user_id, to_cat_id: @trend.to_cat_id, to_user_id: @trend.to_user_id, type: @trend.type }
      # assert_redirected_to trend_path(assigns(:trend))
    end
  end

  test "should destroy trend" do
    assert_difference('Trend.count', -1) do
      delete :destroy, id: @trend
    end

    assert_redirected_to trends_path
  end
end
