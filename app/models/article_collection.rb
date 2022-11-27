# frozen_string_literal: true

class ArticleCollection
  include ArticleValidations

  def initialize(collection_json)
    check_json!(collection_json)

    @articles = collection_json.map do |article_json|
      Article.new(article_json)
    end
  end

  attr_accessor :articles

  class << self
    def new_from_endpoint
      article_json = JSON.parse(ArticleCollection.read_from_endpoint)
      ArticleCollection.new(article_json)
    end

    def read_from_endpoint
      URI.parse(ENDPOINT).read
    end

    ENDPOINT = 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json'
    private_constant :ENDPOINT
  end
end
