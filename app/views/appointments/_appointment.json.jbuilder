json.extract! appointment, :id, :time, :user_id, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
