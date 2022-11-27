# frozen_string_literal: true

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  let(:article_json) { JSON.parse(file_fixture('articles.json').read).first }

  it 'supports all the data keys' do
    assert_equal article_json.keys.sort, Article::DATA_KEYS.map(&:to_s).sort
  end

  describe '#initialize' do
    it 'initializes an Article' do
      article = Article.new(article_json)

      assert article.is_a?(Article)
      Article::DATA_KEYS.each do |key|
        assert_equal article_json[key.to_s], article.public_send(key)
      end
    end

    it 'raises an error if the provided json is invalid' do
      [nil, [], {}, '', '{]'].each do |invalid_json|
        assert_raises Article::InvalidJsonError do
          Article.new(invalid_json)
        end
      end
    end
  end
end
