json.array!(@parts) do |part|
  json.extract! part, :id, :title, :description, :course_id, :start_time, :end_time, :status
  json.url part_url(part, format: :json)
end
