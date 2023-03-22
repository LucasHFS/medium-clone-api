FactoryBot.define do
  factory :article do
    title { "MyString" }
    description { "MyString" }
    body { "MyText" }
    user { nil }
    slug { "MyString" }
  end
end
