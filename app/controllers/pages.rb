get '/pages' do
  @pages = Page.all
  @results = []
  erb :'index'
end

get '/pages/search' do
  queries = get_individual_queries(params[:search_input])

  if queries != []
    @results = get_results(queries).sort { |a,b| b[:ranking] <=> a[:ranking] }
  else
    @results = []
    @error = ["We could not find anything that met your search terms"]
  end

  erb :'index'
end
