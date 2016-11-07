get '/' do
  redirect '/pages'
end

get '/collections/?' do
  content_type :json
  settings.mongo_db.database.collection_names.to_json
end
