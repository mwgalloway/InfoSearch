get '/pages' do
  @pages = Page.all
  @results = []
  erb :'index'
end

get '/pages/search' do
  @results = Page.search(params[:search_input])

  if @results.count == 0
    @results = []
    @error = ["We could not find anything that met your search terms"]
  end

  erb :'index'
end
