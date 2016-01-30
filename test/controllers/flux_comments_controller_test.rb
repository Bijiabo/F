require 'test_helper'

class FluxCommentsControllerTest < ActionController::TestCase
  setup do
    @user = users(:bijiabobo)
    @flux_comment = flux_comments(:one)

    log_in_as @user
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
      post :create, {
          flux_comment: {
              content: @flux_comment.content,
              parentComment: @flux_comment.parentComment,
              user_id: @flux_comment.user_id
          }
      }
    end

    assert_redirected_to flux_comment_path(assigns(:flux_comment))
  end

  test "should create flux comment by json request" do
    log_in_as @user
    assert_difference('FluxComment.count', 1) do
      post :create, {
          flux_comment: {
              content: @flux_comment.content,
              parentComment: @flux_comment.parentComment,
              flux_id: @flux_comment.flux.id
          },
          format: :json,
          token: tokens(:admin).token,
      }

    end

    resultJSON = JSON.parse @response.body
    assert resultJSON["success"]
  end

  test "should not create flux comment for not login" do

    log_out

    assert_no_difference 'FluxComment.count' do
      post :create, {
          flux_comment: {
              content: @flux_comment.content,
              parentComment: @flux_comment.parentComment,
              user_id: @flux_comment.user_id,
              flux_id: @flux_comment.flux.id
          },
          format: :json
      }
    end

    resultJSON = JSON.parse @response.body
    assert_not resultJSON["success"]
  end

  test "should show flux_comment" do
    get :show, id: @flux_comment
    assert_response :success
  end

  # - get edit

  test "should get edit" do
    get :edit, id: @flux_comment
    assert_response :success
  end

  test "should not get edit for did not logged in" do
    log_out
    get :edit, id: @flux_comment
    assert_redirected_to login_url
  end

  # - update

  test "should update flux_comment" do
    patch :update, id: @flux_comment, flux_comment: { content: @flux_comment.content, parentComment: @flux_comment.parentComment, user_id: @flux_comment.user_id }
    assert_redirected_to flux_comment_path(assigns(:flux_comment))
  end

  test "should update flux comment for correct token" do
    log_out

    patch :update, {
        id: @flux_comment,
        flux_comment: {
            content: @flux_comment.content,
            parentComment: @flux_comment.parentComment,
            user_id: @flux_comment.user_id
        },
        token: tokens(:bijiabobo).token,
        format: :json
    }

    result = JSON.parse @response.body
    assert result["success"]
  end

  test "should not update flux comment for not logged in" do
    log_out
    patch :update, id: @flux_comment, flux_comment: { content: @flux_comment.content, parentComment: @flux_comment.parentComment, user_id: @flux_comment.user_id }
    assert_redirected_to login_url
  end

  test "should not update flux comment for wrong token by json request" do
    log_out
    assert_no_difference 'FluxComment.count' do
      patch :update, {
          id: @flux_comment,
          flux_comment: {
              content: @flux_comment.content,
              parentComment: @flux_comment.parentComment,
              user_id: @flux_comment.user_id
          },
          format: :json
      }
    end

    resultJSON = JSON.parse @response.body
    assert_not resultJSON["success"]
  end

  # - destroy

  test "should destroy flux_comment" do
    assert_difference('FluxComment.count', -1) do
      delete :destroy, id: @flux_comment
    end

    assert_redirected_to flux_comments_path
  end

  test "shoud not destroy flux comment for not logged in" do
    log_out
    assert_no_difference 'FluxComment.count' do
      delete :destroy, id: @flux_comment
    end

    assert_redirected_to login_url
  end

  test "should not destroy flux comment for wrong token by json request" do
    log_out
    assert_no_difference 'FluxComment.count' do
      delete :destroy, {
          id: @flux_comment,
          format: :json,
          token: 'xxxxxxxx'
      }
    end

    result = JSON.parse @response.body
    assert_not result["success"]
  end
end
