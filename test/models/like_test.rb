# frozen_string_literal: true

require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  describe 'validations' do
    it 'must have a user_id' do
      like = Like.new(likeable_reference: 'test')
      like.valid?
      assert like.errors.key? :user_id
    end

    it 'must have a likeable_reference' do
      like = Like.new(user: users(:dave))
      like.valid?
      assert like.errors.key? :likeable_reference
    end

    it 'must have a unique user_id and likeable_reference combination' do
      first_like = Like.create!(user: users(:dave), likeable_reference: 1)
      assert first_like.valid?

      second_like = Like.new(user: users(:dave), likeable_reference: 1)
      refute second_like.valid?
      assert second_like.errors.key? :user_id
    end

    it 'allows a user to like multiple likeables' do
      first_like = Like.create!(user: users(:dave), likeable_reference: 1)
      assert first_like.valid?

      second_like = Like.new(user: users(:dave), likeable_reference: 2)
      assert second_like.valid?
    end

    it 'allows a likeable to be liked by multiple users' do
      first_like = Like.create!(user: users(:dave), likeable_reference: 1)
      assert first_like.valid?

      second_like = Like.new(user: users(:joanne), likeable_reference: 1)
      assert second_like.valid?
    end
  end
end
