# frozen_string_literal: true

json.call(article, :id, :title, :slug, :body, :description)
json.createdAt article.created_at
json.updatedAt article.updated_at
