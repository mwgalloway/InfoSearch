require_relative '../spec_helper'
require 'uri'
require 'net/http'

describe "Crawler" do
  let(:uri) {URI.parse("https://kylepdorsey.github.io/test1")}
  let(:response) {Net::HTTP.get_response(uri)}
  let(:noko_doc) {Nokogiri::HTML(response.body)}

  it "Has a method scrape_links that returns an Array of links" do
    expect(Crawler.scrape_links(noko_doc)[0]).to eq("/test2.html")
  end

  it "Has a method external_links that returns an Array of external links" do
    links = Crawler.scrape_links(noko_doc)
    expect(Crawler.external_links(links, uri)[0]).to eq("https://google.com")
  end

  it "Returns an Array of relative links joined with the root url" do
    links = Crawler.scrape_links(noko_doc)
    expect(Crawler.join_relative(uri, links)[0]).to eq("https://kylepdorsey.github.io/test2.html")
  end
end
