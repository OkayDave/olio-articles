# frozen_string_literal: true

require 'test_helper'

class ArticleCollectionTest < ActiveSupport::TestCase
  describe '.new_from_endpoint' do
    let(:article_json) { file_fixture('articles.json').read }

    it 'returns an ArticleCollection' do
      ArticleCollection.stub :read_from_endpoint, article_json do
        collection = ArticleCollection.new_from_endpoint
        assert collection.is_a?(ArticleCollection)
        assert collection.articles.is_a?(Array)
        assert collection.articles.first.is_a?(Article)
      end
    end

    it 'throws an error if the json response is invalid' do
      ArticleCollection.stub :read_from_endpoint, '{]' do
        assert_raises JSON::ParserError do
          ArticleCollection.new_from_endpoint.is_a?(ArticleCollection)
        end
      end
    end
  end
end
