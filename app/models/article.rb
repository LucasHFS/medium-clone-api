# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags

  validates :title, :slug, presence: true
  before_validation :set_slug

  def sorted_tag_list
    tag_list.sort
  end

  def set_slug
    self.slug = "#{title.tr('_', '-').parameterize}-#{Time.now.to_i}"
  end
end
