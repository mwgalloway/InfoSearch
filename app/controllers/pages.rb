
get '/pages' do
  @pages = Page.all
  erb :'index'
end

get '/pages/search' do
  query_words = []
  inputs = params[:search_input].split(" ")
  inputs.each do |input|
    found_word = Word.find_by(text: input)
    if found_word
      query_words << found_word
    end
  end
  p ' ====================== '
  p query_words
  p ' ====================== '
  if query_words != []
    final_results = []

    query_words.each do |word|
      query_results = word.metrics

      query_results.each do |result|
        found_object = final_results.select { |object| object[:page] == result.page }

        if found_object != []
          final_results.delete_if { |object| object[:page] == result.page }
          found_object[0][:ranking] += result.ranking
          final_results << found_object[0]
        else
          final_results << { object: result, page: result.page, ranking: result.ranking }
        end
      end
      
      @results = final_results.sort { |a,b| b[:ranking] <=> a[:ranking] }
    end
  else
    @error = ["We could not find anything that met your search terms"]
  end

  erb :'index'
end

# word1 = Word.find_by(text: "Schiller")
# word1.metrics.sort {|a,b| b.ranking <=> a.ranking}
