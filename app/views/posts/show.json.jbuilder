json.array!(@posts) do |post|
  json.extract! post, :content
  json.created_at format_date_comments(post.created_at)
  json.author post.user.name
end
