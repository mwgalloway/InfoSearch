get '/pages' do
#  @pages = Page.all
  @results = []
  erb :'index'
end

get '/pages/search/:page' do
  @benchmark = Benchmark.realtime{
  @current_page = params[:page].to_i
  skip = @current_page * 10
  @results = Page.search(params[:search_input], skip)
  @results_count = @results.count
  if @results_count == 0
    @results = []
    @error = ["We could not find anything that met your search terms"]
  end

  }
  erb :'index'
end
