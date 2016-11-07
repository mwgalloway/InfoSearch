# require 'uri'
# require 'net/http'
# require 'pry'
# class Indexer
#   @queue = :index

#   def self.perform(args)
#     noko_doc = args[:noko_doc]
#     page_url = args[:page_url]
#     binding.pry
#     Page.add_to_index({url: page_url, noko_doc: noko_doc})
#     # Resque.enqueue(Indexer, page_url, noko_doc)
#   end

# end
