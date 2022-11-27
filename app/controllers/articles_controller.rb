# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index
    @articles = ArticleCollection.new_from_endpoint.articles

    render layout: false
  end
end
