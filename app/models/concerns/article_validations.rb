# frozen_string_literal: true

module ArticleValidations
  extend ActiveSupport::Concern

  InvalidJsonError = Class.new(StandardError)

  included do
    private

    def check_json!(json)
      raise InvalidJsonError if json.nil? || (!json.is_a?(Array) && !json.is_a?(Hash)) || json.empty?
    end
  end
end
