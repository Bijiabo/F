require 'test_helper'

class CatsControllerTest < ActionController::TestCase

  def setup
    @cat = cats(:one)

    @user = users(:bijiabobo)
    @other_user = users(:xxx)
  end

  test "should get new when has logged in" do
    log_in_as @user
    get :new
    assert_response :success
  end

  test "should not get new and redirect when did not logged in" do
    get :new
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @cat
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @cat, cat: { name: @cat.name, age: @cat.age, breed: @cat.breed }
    assert_redirected_to login_url
  end

  test "should return error message when not logged in for edit cat information json request" do
    patch :update, id: @cat, cat: { name: @cat.name, age: @cat.age, breed: @cat.breed }, format: :json
    result = JSON.parse @response.body
    assert result["error"]
  end

  test "should redirect edit when logged in as not the cat owner" do
    log_in_as(@other_user)
    get :edit, id: @cat
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as not the cat owner" do
    log_in_as(@other_user)
    patch :update, id: @cat, cat: { name: @cat.name, age: @cat.age, breed: @cat.breed }
    assert_redirected_to root_url
  end

  test "should edit success for json request" do
    patch :update, {
        id: @cat.id,
        token: tokens(:bijiabobo).token,
        cat: {
            name: @cat.name,
            age: @cat.age,
            breed: @cat.breed
        },
        format: :json
    }
    result = JSON.parse @response.body
    assert result["success"]
  end

  test "should create success for logged in user" do
    # json request
    assert_difference('Cat.count', 1) do
      post :create, {
          cat: { name: @cat.name, age: @cat.age, breed: @cat.breed },
          token: tokens(:bijiabobo).token
      }, format: :json
    end

    # html request
    log_in_as @user
    assert_difference('Cat.count', 1) do
      post :create, {
          cat: { name: @cat.name, age: @cat.age, breed: @cat.breed }
      }
    end
  end

  test "should not destroy for not logged in" do
    assert_no_difference('Cat.count') do
      delete :destroy, id: @cat
    end

    delete :destroy, id: @cat
    assert_redirected_to login_url

    delete :destroy, id: @cat, format: :json
    result = JSON.parse @response.body
    assert result["error"]
  end

  test "should not destroy for not owner" do
    # json request
    delete :destroy, {id: @cat, token: tokens(:admin).token, format: :json}
    result = JSON.parse @response.body
    assert_not result["success"]

    assert_no_difference 'Cat.count' do
      delete :destroy, {id: @cat, token: tokens(:admin).token, format: :json}
    end

    # html request
    log_in_as @other_user
    delete :destroy, id: @cat
    assert_redirected_to root_url
  end

  test "should destroy for owner" do
    # json request
    assert_difference 'Cat.count', -1 do
      delete :destroy, {id: @cat, token: tokens(:bijiabobo).token, format: :json}
    end
  end

  test "should destroy for owner _html_request" do
    # html request
    log_in_as @user
    assert_difference 'Cat.count', -1 do
      delete :destroy, id: @cat
    end
  end


end
