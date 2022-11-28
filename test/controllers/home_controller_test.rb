# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'routes' do
    assert_routing '/', controller: 'home', action: 'index'
  end

  test 'index' do
    get root_url

    assert_response :success
    assert_select 'nav', /OLIO Articles/
  end
end
