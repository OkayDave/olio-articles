# frozen_string_literal: true

module ArticleDataKeys
  extend ActiveSupport::Concern

  DATA_KEYS = %w[
    collection
    collection_notes
    conversations
    created_at
    description
    donation_description
    expiry
    first
    id
    images
    is_owner
    last_listed
    location
    photos
    pickups
    reactions
    section
    status
    title
    updated_at
    user
    value
    veteran_delay
  ].freeze
end
