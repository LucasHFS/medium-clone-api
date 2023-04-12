# frozen_string_literal: true

json.call(article, :id, :title, :slug, :body, :description)
json.tagList article.sorted_tag_list
json.createdAt article.created_at
json.updatedAt article.updated_at
json.author article.user, partial: "profiles/profile", as: :user
