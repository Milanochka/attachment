json.extract! item, :id, :title, :description, :image_url, :price, :created_at, :updated_at
json.url item_url(item, format: :json)
