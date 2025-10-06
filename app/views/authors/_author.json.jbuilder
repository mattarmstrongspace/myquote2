json.extract! author, :id, :auth_fname, :auth_lname, :birth_year, :death_year, :is_anon, :bio, :created_at, :updated_at
json.url author_url(author, format: :json)
