require "services/runners/crawling"
require "domain/batch"
require "domain/link"

describe Runners::Crawling do
  let(:url1)   { "http://example.com/pages/1" }
  let(:url2)   { "http://example.com/pages/2" }

  let(:batch) { Domain::Batch.create(name: "test_batch") }
  
  before do
    Domain::Link.create(url: url1, batch: batch)
    Domain::Link.create(url: url2, batch: batch)
  end

  specify do
    expect_any_instance_of(Crawlers::FaradayParallel)
      .to receive(:call).twice # TODO check arguments

    described_class.new(batch.id).call
  end  
end
