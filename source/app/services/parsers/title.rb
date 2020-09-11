module Parsers
  class Title
    def call(content:)
      Nokogiri::HTML(content).css("title")&.first&.text&.strip
    end
  end
end