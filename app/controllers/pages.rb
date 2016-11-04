
get '/pages' do
  @pages = Page.all
  erb :'index'
end

get '/pages/search' do
  result = Word.find_by(text: params[:search_input])
  if result
    @results = result.metrics.sort {|a,b| b.ranking <=> a.ranking}
  else
    @results = ["We could not find anything that met your search terms"]
  end
  erb :'index'
end

# word1 = Word.find_by(text: "Schiller")
# word1.metrics.sort {|a,b| b.ranking <=> a.ranking}
