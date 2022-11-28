# frozen_string_literal: true

require 'test_helper'

class ArticleCollectionTest < ActiveSupport::TestCase
  describe '.new_from_endpoint' do
    let(:article_json) { file_fixture('articles.json').read }

    describe 'when a user is not passed' do
      it 'returns an ArticleCollection' do
        ArticleCollection.stub :read_from_endpoint, article_json do
          collection = ArticleCollection.new_from_endpoint
          assert collection.is_a?(ArticleCollection)
          assert collection.articles.is_a?(Array)
          assert collection.articles.first.is_a?(Article)
          assert_equal 0, collection.articles.first.reactions['likes']

          assert(collection.articles.all? { |article| article.liked_by_user == false })
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

    describe 'when a user is passed' do
      before do
        json = JSON.parse(article_json)
        Like.create! likeable_reference: json.first['id'], user: users(:dave)
        Like.create! likeable_reference: json.second['id'], user: users(:joanne)
      end

      it 'returns an ArticleCollection with information on if the user has liked each article' do
        ArticleCollection.stub :read_from_endpoint, article_json do
          collection = ArticleCollection.new_from_endpoint(users(:dave))
          assert collection.is_a?(ArticleCollection)
          assert collection.articles.is_a?(Array)
          assert collection.articles.first.is_a?(Article)
          assert collection.articles.first.reactions['likes'] == 1
          assert collection.articles.first.liked_by_user
          refute collection.articles.second.liked_by_user
        end
      end
    end
  end
end
