require 'test_helper'

class FluxesControllerTest < ActionController::TestCase
  setup do
    @user = users(:bijiabobo)
    flux = fluxes(:one)
    @flux = @user.fluxes.create(motion: flux.motion, content: flux.content)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fluxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create flux" do
    assert_difference('Flux.count') do
      post :create, flux: { content: @flux.content, motion: @flux.motion, user_id: @flux.user_id }
    end

    assert_redirected_to flux_path(assigns(:flux))
  end

  test "should show flux" do
    get :show, id: @flux
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @flux
    assert_response :success
  end

  test "should update flux" do
    patch :update, id: @flux, flux: { content: @flux.content, motion: @flux.motion, user_id: @flux.user_id }
    assert_redirected_to flux_path(assigns(:flux))
  end

  test "should destroy flux" do
    assert_difference('Flux.count', -1) do
      delete :destroy, id: @flux
    end

    assert_redirected_to fluxes_path
  end


end
