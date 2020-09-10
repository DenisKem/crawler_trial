require "faraday"
require "nokogiri"

class Parser
  def call(url)
    title(
      Faraday.get(url).body
    )
  end

  private

  def title(body)
    Nokogiri::HTML(body).css("title")&.first&.text&.strip
  end
end
