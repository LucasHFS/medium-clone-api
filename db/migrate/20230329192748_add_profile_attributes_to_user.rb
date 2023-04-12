# frozen_string_literal: true

class AddProfileAttributesToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_column :users, :image_url, :string
    add_column :users, :bio, :text
  end
end
