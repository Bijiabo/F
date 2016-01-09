require 'test_helper'

class FluxCommentsControllerTest < ActionController::TestCase
  setup do
    @flux_comment = flux_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:flux_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create flux_comment" do
    assert_difference('FluxComment.count') do
      post :create, flux_comment: { content: @flux_comment.content, parent_id: @flux_comment.parent_id, user_id: @flux_comment.user_id }
    end

    assert_redirected_to flux_comment_path(assigns(:flux_comment))
  end

  test "should show flux_comment" do
    get :show, id: @flux_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @flux_comment
    assert_response :success
  end

  test "should update flux_comment" do
    patch :update, id: @flux_comment, flux_comment: { content: @flux_comment.content, parent_id: @flux_comment.parent_id, user_id: @flux_comment.user_id }
    assert_redirected_to flux_comment_path(assigns(:flux_comment))
  end

  test "should destroy flux_comment" do
    assert_difference('FluxComment.count', -1) do
      delete :destroy, id: @flux_comment
    end

    assert_redirected_to flux_comments_path
  end
end
