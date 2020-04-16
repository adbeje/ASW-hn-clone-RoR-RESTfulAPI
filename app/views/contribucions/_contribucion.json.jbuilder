json.extract! contribucion, :id, :title, :url, :text, :created_at, :updated_at
json.url contribucion_url(contribucion, format: :json)
