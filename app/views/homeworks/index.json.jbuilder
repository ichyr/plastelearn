json.array!(@homeworks) do |homework|
  json.extract! homework, :id, :description, :part_id, :user_id
  json.url homework_url(homework, format: :json)
end
