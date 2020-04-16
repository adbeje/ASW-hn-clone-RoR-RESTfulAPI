json.extract! reply, :id, :content, :created_at, :updated_at
json.url reply_url(reply, format: :json)
