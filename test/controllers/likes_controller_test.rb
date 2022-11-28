# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  it 'has valid routes' do
    assert_routing({ method: 'post', path: '/likes' }, { controller: 'likes', action: 'create' })
    assert_routing({ method: 'delete', path: '/likes/1' }, { controller: 'likes', action: 'destroy', id: '1' })
  end

  describe 'create' do
    it 'creates a like' do
      login_user users(:dave)

      assert_difference 'Like.count', 1 do
        post likes_path(like: { likeable_reference: 1 })
      end

      assert_redirected_to root_path
    end

    it 'does not create a like if not logged in' do
      assert_no_difference 'Like.count' do
        post likes_path(like: { likeable_reference: 1 })
      end

      assert_redirected_to root_path
    end

    it 'does not create a like if already liked' do
      Like.create!(user: users(:dave), likeable_reference: 1)

      login_user users(:dave)

      assert_no_difference 'Like.count' do
        post likes_path(like: { likeable_reference: 1 })
      end

      assert_redirected_to root_path
    end
  end

  describe 'destroy' do
    it 'destroys a like' do
      like = Like.create!(user: users(:dave), likeable_reference: 1)

      login_user users(:dave)
      assert_difference 'Like.count', -1 do
        delete like_path(like.likeable_reference)
      end

      assert_redirected_to root_path
    end

    it 'does not destroy a like if not logged in' do
      Like.create!(user: users(:dave), likeable_reference: 1)

      assert_no_difference 'Like.count' do
        delete like_path(1)
      end

      assert_redirected_to root_path
    end

    it 'does not destroy a like if not the owner' do
      Like.create!(user: users(:dave), likeable_reference: 1)

      login_user users(:joanne)

      assert_no_difference 'Like.count' do
        delete like_path(1)
      end

      assert_redirected_to root_path
    end
  end
end
