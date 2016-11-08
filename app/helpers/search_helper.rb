module SearchHelper

  # def get_individual_queries(params)
  #   query_words_array = []
  #   input_params = params.split(" ")
  #   input_params.each do |param|
  #     found_word = Word.find_by(text: param)

  #     if found_word
  #       query_words_array << found_word
  #     end
  #   end
  #   query_words_array
  # end

  def get_results(query_words_array)
    if query_words_array != []
      finalized_results = []
      query_words_array.each do |query_word|
        query_results = query_word.metrics
        find_page_objects_and_rankings(query_results, finalized_results)
      end
      finalized_results
    end
  end

  def find_page_objects_and_rankings(query_results, finalized_results)
    query_results.each do |result|
      found_object = finalized_results.select { |object| object[:page] == result.page }

      if found_object != []
        combine_page_rankings(found_object, finalized_results, result)
      else
        finalized_results << { object: result, page: result.page, ranking: result.ranking }
      end
    end
    finalized_results
  end

  def combine_page_rankings(found_object, finalized_results, result)
    finalized_results.delete_if { |object| object[:page] == result.page }

    found_object[0][:ranking] += result.ranking

    finalized_results << found_object[0]
  end
end

helpers SearchHelper
