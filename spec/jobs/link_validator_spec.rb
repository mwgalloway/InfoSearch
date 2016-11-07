require_relative '../spec_helper'


describe "LinkValidator" do
  before do
    ResqueSpec.reset!
  end

  it "adds a valid link to the crawler queue" do
    Resque.enqueue(LinkValidator, "http://www.spacejam.com")
    expect(Resque).to have_queued("http://www.spacejam.com", :scrape)
  end

  it "Returns false if its an absolute URL" do
    link_validation = LinkValidator.url_relative?("http://www.google.com")
    expect(link_validation).to eq(false)
  end

  it "Returns true if its an relative URL" do
    link_validation = LinkValidator.url_relative?("/Spacejab")
    expect(link_validation).to eq(true)
  end

  it "Returns true if its an valid link" do
    link_validation = LinkValidator.link_valid?("http://www.spacejab.com")
    expect(link_validation).to eq(true)
  end

  it "Returns false if its an invalid link" do
    link_validation = LinkValidator.link_valid?("spacejabbing.pdf")
    expect(link_validation).to eq(false)
  end

  xit "Creates concatenated link with trailing slash" do
    concat = LinkValidator.concat_relative("http://www.spacejab.com","/spacejabbing")
    expect(concat).to eq("http://www.spacejab.com/spacejabbing")
  end

  xit "Creates concatenated link without slash" do
    concat = LinkValidator.concat_relative("http://www.spacejab.com","spacejabbing")
    expect(concat).to eq("http://www.spacejab.com/spacejabbing")
  end

  xit "Concatenates http:// when it is not included" do
    concat = LinkValidator.concat_relative("http://www.wikipedia.org","//wikimedia.org/photos")
    expect(concat).to eq("http://www.wikimedia.org/photos")
  end

  xit "Returns a absolute link without modifying" do
    concat = LinkValidator.concat_relative("http://www.wikipedia.org","//wikimedia.org/photos")
    expect(concat).to eq("http://www.wikimedia.org/photos")
  end
end
