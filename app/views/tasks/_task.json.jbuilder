json.extract! task, :id, :type, :start_time, :end_time, :description, :location, :created_at, :updated_at
json.url task_url(task, format: :json)
