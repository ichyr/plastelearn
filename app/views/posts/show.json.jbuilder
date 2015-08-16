json.array!(@posts) do |post|
  json.extract! post, :content, :created_at
  json.author post.user.name
end
