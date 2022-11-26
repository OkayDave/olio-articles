# frozen_string_literal: true

require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test 'routes' do
    assert_routing '/articles', controller: 'articles', action: 'index'
  end
end
