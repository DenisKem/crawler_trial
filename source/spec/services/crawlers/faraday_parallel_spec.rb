require "../app/services/crawlers/faraday_parallel"
require "../app/dto/request"

describe Crawlers::FaradayParallel do
  let(:url1) { "http://example.com/pages/1" }
  let(:url2) { "http://example.com/pages/2" }

  let(:request1) { DTO::Request.new(url1) }
  let(:request2) { DTO::Request.new(url2) }

  let(:title1) { "Page one" }
  let(:title2) { "Page two" }

  def html(title)
    <<~HTML
      <html>
        <head>
          <title>
            #{title}
          </title>
        </head>
      </html>
    HTML
  end

  before do
    stub_request(:get, url1).to_return(status: 200, body: html(title1))
    stub_request(:get, url2).to_return(status: 200, body: html(title2))
  end

  specify do
    described_class.new.call([request1, request2])
    
    expect(request1.title).to eq(title1)
    expect(request2.title).to eq(title2)
  end
end

# Отдаем объект с запросом
# В нем хранится url и есть аттрибуты request и title
# После того как исполнится блок parallels мы пробегаем по объектам
# Передаем каждый объект в парсер
# Парсер записывает атрибут title