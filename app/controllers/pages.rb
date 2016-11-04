
get '/pages' do
  @pages = Page.all
  erb :'index'
end

post '/pages' do

  @results = Word.find_by(text: params[:search_input])
end
