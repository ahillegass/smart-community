json.extract! user, :id, :first_name, :last_name, :email, :auth_token, :created_at, :updated_at
json.url api_users_url(user, format: :json)
