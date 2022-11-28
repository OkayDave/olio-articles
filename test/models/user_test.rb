# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  describe 'validations' do
    it 'requires an email' do
      user = User.new(email: nil)

      refute user.valid?
      assert_equal ["can't be blank", 'is invalid'], user.errors[:email]
    end

    it 'requires a unique email' do
      user = User.new(email: users(:dave).email)

      refute user.valid?
      assert_equal ['has already been taken'], user.errors[:email]
    end

    it 'requires a valid email' do
      user = User.new(email: 'invalid')

      refute user.valid?
      assert_equal ['is invalid'], user.errors[:email]
    end

    it 'requires a password of at least 8 characters' do
      user = User.new(password: '1234567')

      refute user.valid?
      assert_equal ['is too short (minimum is 8 characters)'], user.errors[:password]
    end
  end
end
