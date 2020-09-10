require "../app/services/parser"

describe Parser do
  let(:title) { "Example" }
  let(:url)   { "http://example.com/some/data.html" }

  let(:service) { described_class.new }

  let(:body) { <<~HTML }
    <html>
      <head>
        <title>
          #{title}
        </title>
      </head>
    </html>
  HTML

  before do
    stub_request(:get, url).to_return(status: 200, body: body)
  end

  describe "#call" do
    it "returns title from page" do
      expect(service.call(url)).to eq(title)
    end

    context "when not title provided" do
      let(:body) { "<html></html>" }

      it "returns nil" do
        expect(service.call(url)).to be_nil
      end
    end
  end
end
