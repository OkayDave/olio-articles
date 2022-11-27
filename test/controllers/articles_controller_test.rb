# frozen_string_literal: true

require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  it 'has a valid route' do
    assert_routing '/articles', controller: 'articles', action: 'index'
  end

  describe '#index' do
    let(:article_json) { file_fixture('articles.json').read }
    let(:articles) { JSON.parse(article_json) }

    it 'renders the list of articles' do
      ArticleCollection.stub(:read_from_endpoint, article_json) do
        get articles_url

        assert_response :success
        assert_select "#article_#{articles.first['id']}", 1
        assert_select '.article', articles.count
      end
    end
  end
end
