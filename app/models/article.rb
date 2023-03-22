# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  validates :title, :slug, presence: true
  before_validation :set_slug

  def set_slug
    self.slug = "#{title.tr('_', '-').parameterize}-#{Time.now.to_i}"
  end
end
