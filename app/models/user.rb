# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password,
            confirmation: true,
            length: { minimum: 8 },
            if: -> { new_record? || changes[:crypted_password] }

  attr_accessor :password, :password_confirmation
end
