json.array!(@course.parts) do |part|
  json.start part.start_time.strftime("%F")  
  json.end part.end_time.strftime("%F")  
  json.extract! part, :title
end
