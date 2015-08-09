json.array!(@posts) do |post|
  json.extract! post, :id, :parent_id, :course_id, :content, :user_id
  json.url post_url(post, format: :json)
end
