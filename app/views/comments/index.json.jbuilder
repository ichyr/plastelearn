json.array!(@comments) do |comment|
  json.extract! comment, :id, :text, :homework_id
  json.url comment_url(comment, format: :json)
end
