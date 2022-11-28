# frozen_string_literal: true

class Article
  include ArticleDataKeys
  include ArticleValidations

  DATA_KEYS.each do |key|
    attr_accessor key
  end

  attr_accessor :liked_by_user

  def initialize(article_json)
    check_json!(article_json)

    DATA_KEYS.each do |key|
      public_send "#{key}=", article_json[key.to_s]
    end
  end
end
