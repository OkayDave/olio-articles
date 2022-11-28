# frozen_string_literal: true

class ArticleCollection
  include ArticleValidations

  def initialize(collection_json, user = nil)
    check_json!(collection_json)

    @articles = collection_json.map do |article_json|
      Article.new(article_json).tap do |article|
        article.liked_by_user = liked_by_user?(article, user)
        article.reactions['likes'] = like_count(article)
      end
    end
  end

  attr_accessor :articles

  private

  def like_count(article)
    @like_counts ||= Like.group(:likeable_reference).count

    @like_counts.fetch(article.id, 0) + article.reactions.fetch('likes', 0)
  end

  def liked_by_user?(article, user)
    return false unless user

    @user_likes ||= Like.where(user:)
                        .uniq
                        .pluck(:likeable_reference)

    @user_likes.include?(article.id)
  end

  class << self
    def new_from_endpoint(user = nil)
      article_json = JSON.parse(ArticleCollection.read_from_endpoint)
      ArticleCollection.new(article_json, user)
    end

    def read_from_endpoint
      URI.parse(ENDPOINT).read
    end

    ENDPOINT = 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json'
    private_constant :ENDPOINT
  end
end
