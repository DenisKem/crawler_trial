require "services/crawlers/faraday_parallel"
require "dto/request"

module Runners
  class Crawling
    attr_reader :batch_id

    def initialize(batch_id)
      self.batch_id = batch_id
    end

    def call
      Crawlers::FaradayParallel.new(requests)
    end

    private

    def requests
      links.map do |link|
        DTO::Request.new(link[:url])
      end
    end

    def links
      Domain::Link
        .where(batch_id: batch_id)
        .order(Sequel[:id].desc)
        .all
    end
  end
end
