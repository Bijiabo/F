require 'test_helper'

class FluxesIndexTestTest < ActionDispatch::IntegrationTest

  test "index should inclouding pagnigate" do
    get fluxes_path
    assert_template 'fluxes/index'

    assert_select 'ul.pagination'
  end

end
