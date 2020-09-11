require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'nokogiri'
require '../app/services/parsers/title'

module Crawlers
  class FaradayParallel
    def initialize
      @connection = Faraday.new { |faraday| faraday.adapter :typhoeus }
      @parser = Parsers::Title.new
    end

    def call(requests)
      perform(requests)
      parse(requests)
    end

    private

    def perform(requests)
      @connection.in_parallel do
        requests.each do |request|
          request.response = @connection.get(request.url)
        end
      end
    end

    def parse(requests)
      requests.map do |request|
        request.title = @parser.call(content: request.response.body)
      end
    end
  end
end
