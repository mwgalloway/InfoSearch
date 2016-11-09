# require_relative '../spec_helper'


# describe "LinkValidator" do
#   let(:crawler) {Crawler.new()}
#   let(:test_url) {"https://kylepdorsey.github.io/test1.html"}

#   after(:each) do
#     Page.destroy_all({:url => test_url})
#   end

#   it "Creates a new Page record related to the input URL" do
#     crawler.perform(test_url)
#     expect(Page.find_by(url: test_url)).to be_an_instance_of(Page.class)
#   end
# end
