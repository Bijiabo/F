require 'test_helper'

class FluxesControllerTest < ActionController::TestCase
  setup do
    @user = users(:bijiabobo)
    log_in_as @user

    flux = fluxes(:one)
    @flux = @user.fluxes.create(motion: flux.motion, content: flux.content)
  end

  #test get index

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fluxes)
  end

  test "should display create form when logged in" do
    get :index
    assert_select "form.new_flux"
  end

  # test get new

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should not get new" do
    log_out
    get :new
    assert_redirected_to login_url
  end

  # test create

  test "should create flux" do
    assert_difference('Flux.count') do
      post :create, flux: {content: @flux.content, motion: @flux.motion, user_id: @flux.user_id}
    end

    assert_redirected_to fluxes_url
  end

  test "should not post create when did not logged in" do
    log_out

    assert_no_difference('Flux.count') do
      post :create, flux: {content: @flux.content, motion: @flux.motion, user_id: @flux.user_id}
    end

    assert_redirected_to login_url
  end

  # test show

  test "should show flux" do
    get :show, id: @flux
    assert_template 'fluxes/show'
    assert_response :success
  end

  test "should not display edit and destroy link when is not correct user" do
    log_out
    get :show, id: @flux
    assert_select 'a[href=?]', edit_flux_path, count: 0

    log_in_as users(:admin)
    get :show, id: @flux
    assert_select 'a[href=?]', edit_flux_path, count: 0
  end

  # test get edit

  test "should get edit as correct user" do
    get :edit, id: @flux
    assert_response :success
  end

  test "should not get edit as not correct user" do
    log_in_as users(:admin)
    get :edit, id: @flux

    assert_redirected_to fluxes_url
  end

  test "should not get edit when did not logged in" do
    log_out
    get :edit, id: @flux
    assert_redirected_to login_url
  end

  # test update

  test "should not patch update when did not logged in" do
    log_out
    patch :update, id: @flux, flux: {content: @flux.content, motion: @flux.motion, user_id: @flux.user_id}
    assert_redirected_to login_url
  end

  test "should update flux as correct user" do
    patch :update, id: @flux, flux: {content: @flux.content, motion: @flux.motion, user_id: @flux.user_id}
    assert_redirected_to flux_path(assigns(:flux))
  end

  test "should not update flux as not correct user" do
    log_in_as users(:admin)
    patch :update, id: @flux, flux: {content: @flux.content, motion: @flux.motion, user_id: @flux.user_id}
    assert_redirected_to fluxes_url
  end

  test "should not update flux as not correct user for json reqeust" do
    log_out
    patch :update, {
        id: @flux.id,
        token: tokens(:admin).token,
        flux: {content: @flux.content, motion: @flux.motion, user_id: @flux.user_id}
    }, format: :json
    resultJSON = JSON.parse @response.body
    assert resultJSON["error"]
  end

  # test destroy

  test "should not destroy flux when is not correct user or did not logged in" do
    log_out
    assert_no_difference('Flux.count') do
      delete :destroy, id: @flux
    end
    assert_redirected_to login_url

    log_in_as users(:admin)
    assert_no_difference('Flux.count') do
      delete :destroy, id: @flux
    end
    assert_redirected_to fluxes_url
  end

  test "should not destroy flux when is not correct user or did not logged in for json request" do

    log_out
    assert_no_difference('Flux.count') do
      delete :destroy, id: @flux, format: :json
    end
    reslutJSON = ActiveSupport::JSON.decode @response.body
    assert reslutJSON["error"]

    log_out
    assert_no_difference('Flux.count') do
      delete :destroy, id: @flux.id, token: tokens(:admin).token, format: :json
    end
    resultJSON = ActiveSupport::JSON.decode @response.body
    assert resultJSON["error"]
  end

  test "should destroy flux" do
    assert_difference('Flux.count', -1) do
      delete :destroy, id: @flux
    end

    assert_redirected_to fluxes_path
  end

  test "should destroy flux for json request" do
    log_out
    assert_difference('Flux.count', -1) do
      delete :destroy, id: @flux.id, token: tokens(:bijiabobo).token, format: :json
    end
    resultJSON = ActiveSupport::JSON.decode @response.body
    assert resultJSON["success"]
  end

  test "fluxes interface" do
    log_in_as(@user)
    get :index
    assert_select 'ul.pagination'
    assert_select 'input[type=submit]'
    # invalid post
    post :create, flux: {content: "", motion: "share_image", user_id: @user.id}
    assert_select 'div#error_explanation'
    # valid post
    content = "This fluxes really ties the room together"
    picture = fixture_file_upload('test.jpg', 'image/jpeg')
    assert_difference 'Flux.count', 1 do
      post :create, flux: {content: content, motion: "share_image", picture: picture}
    end
    assert Flux.first.picture?
    # TODO: fix this
    # follow_redirect!
    # assert_match content, response.body
    # delete a flux
    # assert_select 'a', 'delete'
    # first_flux = @user.fluxes.paginate(page: 1).first
    # assert_difference 'Flux.count', -1 do
    #   delete fluxes_path(first_flux)
    # end
    # other user page
    # get user_path(users(:admin))
    # assert_select 'a', {text: 'delete', count: 0}
  end

end
