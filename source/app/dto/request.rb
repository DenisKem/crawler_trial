module DTO
  class Request
    attr_accessor :url
    attr_accessor :response
    attr_accessor :title

    def initialize(url)
      self.url = url
    end
  end
end