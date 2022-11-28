# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :likeable_reference, null: false
      t.timestamps
    end

    add_index :likes, %i[likeable_reference user_id], unique: true
  end
end
