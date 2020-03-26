json.extract! contribucion, :id, :title, :url, :text, :created_at, :updated_at, :points
json.url contribucion_url(contribucion, format: :json)
