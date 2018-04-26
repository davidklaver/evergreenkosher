json.extract! donation_item, :id, :name, :price, :image_url, :created_at, :updated_at
json.url donation_item_url(donation_item, format: :json)
