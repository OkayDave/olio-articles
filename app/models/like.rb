# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user,
             inverse_of: :likes,
             foreign_key: :user_id

  validates :user_id, presence: true
  validates :likeable_reference, presence: true

  validates_uniqueness_of :user_id, scope: :likeable_reference
end
